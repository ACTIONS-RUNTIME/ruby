//! Code to track assumptions made during code generation and invalidate
//! generated code if and when these assumptions are invalidated.

use crate::core::*;
use crate::cruby::*;
use crate::codegen::*;
use crate::stats::*;
use crate::asm::OutlinedCb;
use crate::yjit::yjit_enabled_p;
use std::collections::HashMap;

// Invariants to track:
// assume_bop_not_redefined(jit, INTEGER_REDEFINED_OP_FLAG, BOP_PLUS)
// assume_method_lookup_stable(comptime_recv_klass, cme, jit);
// assume_single_ractor_mode(jit)
// assume_stable_global_constant_state(jit);

/// Used to track all of the various block references that contain assumptions
/// about the state of the virtual machine.
pub struct Invariants {
    /// Tracks block assumptions about the stability of a basic operator on a
    /// given class.
    basic_operators: HashMap<(RedefinitionFlag, ruby_basic_operators), Vec<BlockRef>>,

    /// Tracks block assumptions about callable method entry validity.
    cme_validity: HashMap<*const rb_callable_method_entry_t, Vec<BlockRef>>,

    /// Tracks block assumptions about method lookup. Maps a class to a table of
    /// method ID points to a set of blocks. While a block `b` is in the table,
    /// b->callee_cme == rb_callable_method_entry(klass, mid).
    method_lookup: HashMap<VALUE, HashMap<ID, Vec<(BlockRef, ID)>>>,

    /// Tracks the set of blocks that are assuming the interpreter is running
    /// with only one ractor. This is important for things like accessing
    /// constants which can have different semantics when multiple ractors are
    /// running.
    single_ractor: Vec<BlockRef>,

    /// Tracks the set of blocks that are assuming that the global constant
    /// state hasn't changed since the last time it was checked. This is
    /// important for accessing constants and their fields which can change
    /// between executions of a given block.
    global_constant_state: Vec<BlockRef>
}

/// Private singleton instance of the invariants global struct.
static mut INVARIANTS: Option<Invariants> = None;

impl Invariants {
    pub fn init() {
        // Wrapping this in unsafe to assign directly to a global.
        unsafe {
            INVARIANTS = Some(Invariants {
                basic_operators: HashMap::new(),
                cme_validity: HashMap::new(),
                method_lookup: HashMap::new(),
                single_ractor: Vec::new(),
                global_constant_state: Vec::new()
            });
        }
    }

    /// Get a mutable reference to the codegen globals instance
    pub fn get_instance() -> &'static mut Invariants {
        unsafe { INVARIANTS.as_mut().unwrap() }
    }
}

/// A public function that can be called from within the code generation
/// functions to ensure that the block being generated is invalidated when the
/// basic operator is redefined.
pub fn assume_bop_not_redefined(jit: &mut JITState, ocb: &mut OutlinedCb, klass: RedefinitionFlag, bop: ruby_basic_operators) -> bool {
    if unsafe { BASIC_OP_UNREDEFINED_P(bop, klass) } {
        jit_ensure_block_entry_exit(jit, ocb);

        // First, fetch the entry in the list of basic operators that
        // corresponds to this class and basic operator tuple.
        let entry = Invariants::get_instance().basic_operators.entry((klass, bop));

        // Next, add the current block to the list of blocks that are assuming
        // this basic operator is not redefined.
        entry.or_insert(Vec::new()).push(jit.get_block());

        return true;
    } else {
        return false;
    }
}

// Remember that a block assumes that
// `rb_callable_method_entry(receiver_klass, cme->called_id) == cme` and that
// `cme` is valid.
// When either of these assumptions becomes invalid, rb_yjit_method_lookup_change() or
// rb_yjit_cme_invalidate() invalidates the block.
//
// @raise NoMemoryError
pub fn assume_method_lookup_stable(jit: &mut JITState, ocb: &mut OutlinedCb, receiver_klass: VALUE, callee_cme: *const rb_callable_method_entry_t) {
    // RUBY_ASSERT(rb_callable_method_entry(receiver_klass, cme->called_id) == cme);
    // RUBY_ASSERT_ALWAYS(RB_TYPE_P(receiver_klass, T_CLASS) || RB_TYPE_P(receiver_klass, T_ICLASS));
    // RUBY_ASSERT_ALWAYS(!rb_objspace_garbage_object_p(receiver_klass));

    jit_ensure_block_entry_exit(jit, ocb);

    let block = jit.get_block();
    block.borrow_mut().add_cme_dependency(receiver_klass, callee_cme);

    Invariants::get_instance().cme_validity.entry(callee_cme).or_insert(Vec::new()).push(block.clone());

    let mid = unsafe { (*callee_cme).called_id };
    Invariants::get_instance().method_lookup
        .entry(receiver_klass).or_insert(HashMap::new())
        .entry(mid).or_insert(Vec::new())
        .push((block.clone(), mid));
}

/// Tracks that a block is assuming it is operating in single-ractor mode.
pub fn assume_single_ractor_mode(jit: &mut JITState, ocb: &mut OutlinedCb) -> bool {
    if unsafe { rb_yjit_multi_ractor_p() } {
        false
    } else {
        jit_ensure_block_entry_exit(jit, ocb);
        Invariants::get_instance().single_ractor.push(jit.get_block());
        true
    }
}

/// Tracks that a block is assuming that the global constant state has not
/// changed since the last call to this function.
pub fn assume_stable_global_constant_state(jit: &mut JITState, ocb: &mut OutlinedCb) {
    jit_ensure_block_entry_exit(jit, ocb);
    Invariants::get_instance().global_constant_state.push(jit.get_block());
}

/// Called when a basic operation is redefined.
#[no_mangle]
pub extern "C" fn rb_yjit_bop_redefined(klass: RedefinitionFlag, bop: ruby_basic_operators) {
    for block in Invariants::get_instance().basic_operators.entry((klass, bop)).or_insert(Vec::new()).iter() {
        invalidate_block_version(block);
        incr_counter!(invalidate_bop_redefined);
    }
}

/// Callback for when a cme becomes invalid. Invalidate all blocks that depend
/// on the given cme being valid.
#[no_mangle]
pub extern "C" fn rb_yjit_cme_invalidate(callee_cme: *const rb_callable_method_entry_t) {
    // If YJIT isn't enabled, do nothing
    if !yjit_enabled_p() {
        return;
    }

    Invariants::get_instance().cme_validity.remove(&callee_cme).map(|blocks| {
        for block in blocks.iter() {
            invalidate_block_version(block);
            incr_counter!(invalidate_method_lookup);
        }
    });
}

/// Callback for when rb_callable_method_entry(klass, mid) is going to change.
/// Invalidate blocks that assume stable method lookup of `mid` in `klass` when this happens.
/// This needs to be wrapped on the C side with RB_VM_LOCK_ENTER().
#[no_mangle]
pub extern "C" fn rb_yjit_method_lookup_change(klass: VALUE, mid: ID) {
    // If YJIT isn't enabled, do nothing
    if !yjit_enabled_p() {
        return;
    }

    Invariants::get_instance().method_lookup.entry(klass).and_modify(|deps| {
        deps.remove(&mid).map(|deps| {
            for (block, mid) in deps.iter() {
                invalidate_block_version(block);
                incr_counter!(invalidate_method_lookup);
            }
        });
    });
}

/// Callback for then Ruby is about to spawn a ractor. In that case we need to
/// invalidate every block that is assuming single ractor mode.
#[no_mangle]
pub extern "C" fn rb_yjit_before_ractor_spawn() {
    for block in Invariants::get_instance().single_ractor.iter() {
        invalidate_block_version(block);
        incr_counter!(invalidate_ractor_spawn);
    }
}

/// Callback for when the global constant state changes.
#[no_mangle]
pub extern "C" fn rb_yjit_constant_state_changed() {
    // If YJIT isn't enabled, do nothing
    if !yjit_enabled_p() {
        return;
    }

    for block in Invariants::get_instance().global_constant_state.iter() {
        invalidate_block_version(block);
        incr_counter!(invalidate_constant_state_bump);
    }
}

/*
static void
yjit_block_assumptions_free(block_t *block)
{
    st_data_t as_st_data = (st_data_t)block;
    if (blocks_assuming_stable_global_constant_state) {
        st_delete(blocks_assuming_stable_global_constant_state, &as_st_data, NULL);
    }

    if (blocks_assuming_single_ractor_mode) {
        st_delete(blocks_assuming_single_ractor_mode, &as_st_data, NULL);
    }

    if (blocks_assuming_bops) {
        st_delete(blocks_assuming_bops, &as_st_data, NULL);
    }
}
*/

/*
// Free the yjit resources associated with an iseq
void
rb_yjit_iseq_free(const struct rb_iseq_constant_body *body)
{
    rb_darray_for(body->yjit_blocks, version_array_idx) {
        rb_yjit_block_array_t version_array = rb_darray_get(body->yjit_blocks, version_array_idx);

        rb_darray_for(version_array, block_idx) {
            block_t *block = rb_darray_get(version_array, block_idx);
            yjit_free_block(block);
        }

        rb_darray_free(version_array);
    }

    rb_darray_free(body->yjit_blocks);
}
*/





/*

// Callback from the opt_setinlinecache instruction in the interpreter.
// Invalidate the block for the matching opt_getinlinecache so it could regenerate code
// using the new value in the constant cache.
void
rb_yjit_constant_ic_update(const rb_iseq_t *const iseq, IC ic)
{
    if (!rb_yjit_enabled_p()) return;

    // We can't generate code in these situations, so no need to invalidate.
    // See gen_opt_getinlinecache.
    if (ic->entry->ic_cref || rb_multi_ractor_p()) {
        return;
    }

    RB_VM_LOCK_ENTER();
    rb_vm_barrier(); // Stop other ractors since we are going to patch machine code.
    {
        const struct rb_iseq_constant_body *const body = iseq->body;
        VALUE *code = body->iseq_encoded;
        const unsigned get_insn_idx = ic->get_insn_idx;

        // This should come from a running iseq, so direct threading translation
        // should have been done
        RUBY_ASSERT(FL_TEST((VALUE)iseq, ISEQ_TRANSLATED));
        RUBY_ASSERT(get_insn_idx < body->iseq_size);
        RUBY_ASSERT(rb_vm_insn_addr2insn((const void *)code[get_insn_idx]) == BIN(opt_getinlinecache));

        // Find the matching opt_getinlinecache and invalidate all the blocks there
        RUBY_ASSERT(insn_op_type(BIN(opt_getinlinecache), 1) == TS_IC);
        if (ic == (IC)code[get_insn_idx + 1 + 1]) {
            rb_yjit_block_array_t getinlinecache_blocks = yjit_get_version_array(iseq, get_insn_idx);

            // Put a bound for loop below to be defensive
            const int32_t initial_version_count = rb_darray_size(getinlinecache_blocks);
            for (int32_t iteration=0; iteration<initial_version_count; ++iteration) {
                getinlinecache_blocks = yjit_get_version_array(iseq, get_insn_idx);

                if (rb_darray_size(getinlinecache_blocks) > 0) {
                    block_t *block = rb_darray_get(getinlinecache_blocks, 0);
                    invalidate_block_version(block);
#if YJIT_STATS
                    yjit_runtime_counters.invalidate_constant_ic_fill++;
#endif
                }
                else {
                    break;
                }
            }

            // All versions at get_insn_idx should now be gone
            RUBY_ASSERT(0 == rb_darray_size(yjit_get_version_array(iseq, get_insn_idx)));
        }
        else {
            RUBY_ASSERT(false && "ic->get_insn_diex not set properly");
        }
    }
    RB_VM_LOCK_LEAVE();
}
*/

// Invalidate all generated code and patch C method return code to contain
// logic for firing the c_return TracePoint event. Once rb_vm_barrier()
// returns, all other ractors are pausing inside RB_VM_LOCK_ENTER(), which
// means they are inside a C routine. If there are any generated code on-stack,
// they are waiting for a return from a C routine. For every routine call, we
// patch in an exit after the body of the containing VM instruction. This makes
// it so all the invalidated code exit as soon as execution logically reaches
// the next VM instruction. The interpreter takes care of firing the tracing
// event if it so happens that the next VM instruction has one attached.
//
// The c_return event needs special handling as our codegen never outputs code
// that contains tracing logic. If we let the normal output code run until the
// start of the next VM instruction by relying on the patching scheme above, we
// would fail to fire the c_return event. The interpreter doesn't fire the
// event at an instruction boundary, so simply exiting to the interpreter isn't
// enough. To handle it, we patch in the full logic at the return address. See
// full_cfunc_return().
//
// In addition to patching, we prevent future entries into invalidated code by
// removing all live blocks from their iseq.
#[no_mangle]
pub extern "C" fn rb_yjit_tracing_invalidate_all()
{
    if !yjit_enabled_p() {
        return;
    }

    todo!();
/*
    // Stop other ractors since we are going to patch machine code.
    RB_VM_LOCK_ENTER();
    rb_vm_barrier();

    // Make it so all live block versions are no longer valid branch targets
    rb_objspace_each_objects(tracing_invalidate_all_i, NULL);

    // Apply patches
    const uint32_t old_pos = cb->write_pos;
    rb_darray_for(global_inval_patches, patch_idx) {
        struct codepage_patch patch = rb_darray_get(global_inval_patches, patch_idx);
        cb.set_pos(patch.inline_patch_pos);
        uint8_t *jump_target = cb_get_ptr(ocb, patch.outlined_target_pos);
        jmp_ptr(cb, jump_target);
    }
    cb.set_pos(old_pos);

    // Freeze invalidated part of the codepage. We only want to wait for
    // running instances of the code to exit from now on, so we shouldn't
    // change the code. There could be other ractors sleeping in
    // branch_stub_hit(), for example. We could harden this by changing memory
    // protection on the frozen range.
    RUBY_ASSERT_ALWAYS(yjit_codepage_frozen_bytes <= old_pos && "frozen bytes should increase monotonically");
    yjit_codepage_frozen_bytes = old_pos;

    cb_mark_all_executable(ocb);
    cb_mark_all_executable(cb);
    RB_VM_LOCK_LEAVE();
*/
}

/*
static int
tracing_invalidate_all_i(void *vstart, void *vend, size_t stride, void *data)
{
    VALUE v = (VALUE)vstart;
    for (; v != (VALUE)vend; v += stride) {
        void *ptr = asan_poisoned_object_p(v);
        asan_unpoison_object(v, false);

        if (rb_obj_is_iseq(v)) {
            rb_iseq_t *iseq = (rb_iseq_t *)v;
            invalidate_all_blocks_for_tracing(iseq);
        }

        asan_poison_object_if(ptr, v);
    }
    return 0;
}

static void
invalidate_all_blocks_for_tracing(const rb_iseq_t *iseq)
{
    struct rb_iseq_constant_body *body = iseq->body;
    if (!body) return; // iseq yet to be initialized

    ASSERT_vm_locking();

    // Empty all blocks on the iseq so we don't compile new blocks that jump to the
    // invalidted region.
    // TODO Leaking the blocks for now since we might have situations where
    // a different ractor is waiting in branch_stub_hit(). If we free the block
    // that ractor can wake up with a dangling block.
    rb_darray_for(body->yjit_blocks, version_array_idx) {
        rb_yjit_block_array_t version_array = rb_darray_get(body->yjit_blocks, version_array_idx);
        rb_darray_for(version_array, version_idx) {
            // Stop listening for invalidation events like basic operation redefinition.
            block_t *block = rb_darray_get(version_array, version_idx);
            yjit_unlink_method_lookup_dependency(block);
            yjit_block_assumptions_free(block);
        }
        rb_darray_free(version_array);
    }
    rb_darray_free(body->yjit_blocks);
    body->yjit_blocks = NULL;

#if USE_MJIT
    // Reset output code entry point
    body->jit_func = NULL;
#endif
}
*/
