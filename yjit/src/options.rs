use std::{ffi::{CStr, CString}, ptr::null};
use crate::backend::current::TEMP_REGS;
use std::os::raw::{c_char, c_int, c_uint};

// Command-line options
#[derive(Clone, PartialEq, Eq, Debug)]
#[repr(C)]
pub struct Options {
    // Size of the executable memory block to allocate in bytes
    // Note that the command line argument is expressed in MiB and not bytes
    pub exec_mem_size: usize,

    // Number of method calls after which to start generating code
    // Threshold==1 means compile on first execution
    pub call_threshold: usize,

    // Number of execution requests after which a method is no longer
    // considered hot. Raising this results in more generated code.
    pub cold_threshold: usize,

    // Generate versions greedily until the limit is hit
    pub greedy_versioning: bool,

    // Disable the propagation of type information
    pub no_type_prop: bool,

    // Maximum number of versions per block
    // 1 means always create generic versions
    pub max_versions: usize,

    // The number of registers allocated for stack temps
    pub num_temp_regs: usize,

    // Capture stats
    pub gen_stats: bool,

    // Print stats on exit (when gen_stats is also true)
    pub print_stats: bool,

    // Trace locations of exits
    pub gen_trace_exits: bool,

    // how often to sample exit trace data
    pub trace_exits_sample_rate: usize,

    // Whether to start YJIT in paused state (initialize YJIT but don't
    // compile anything)
    pub pause: bool,

    // Stop generating new code when exec_mem_size is reached. Don't run code GC
    pub disable_code_gc: bool,

    /// Dump compiled and executed instructions for debugging
    pub dump_insns: bool,

    /// Dump all compiled instructions of target cbs.
    pub dump_disasm: Option<DumpDisasm>,

    /// Print when specific ISEQ items are compiled or invalidated
    pub dump_iseq_disasm: Option<String>,

    /// Verify context objects (debug mode only)
    pub verify_ctx: bool,
}

// Initialize the options to default values
pub static mut OPTIONS: Options = Options {
    exec_mem_size: 128 * 1024 * 1024,
    call_threshold: 30,
    cold_threshold: 200_000,
    greedy_versioning: false,
    no_type_prop: false,
    max_versions: 4,
    num_temp_regs: 5,
    gen_stats: false,
    gen_trace_exits: false,
    print_stats: true,
    trace_exits_sample_rate: 0,
    pause: false,
    disable_code_gc: false,
    dump_insns: false,
    dump_disasm: None,
    verify_ctx: false,
    dump_iseq_disasm: None,
};

/// YJIT option descriptions for `ruby --help`.
static YJIT_OPTIONS: [(&str, &str); 9] = [
    ("--yjit-stats",                    "Enable collecting YJIT statistics"),
    ("--yjit-trace-exits",              "Record Ruby source location when exiting from generated code"),
    ("--yjit-trace-exits-sample-rate",  "Trace exit locations only every Nth occurrence"),
    ("--yjit-exec-mem-size=num",        "Size of executable memory block in MiB (default: 128)"),
    ("--yjit-disable-code-gc",          "Don't run code GC after exhausting exec-mem-size"),
    ("--yjit-call-threshold=num",       "Number of calls to trigger JIT (default: 30)"),
    ("--yjit-cold-threshold=num",       "Global call after which ISEQs not compiled (default: 200K)"),
    ("--yjit-max-versions=num",         "Maximum number of versions per basic block (default: 4)"),
    ("--yjit-greedy-versioning",        "Greedy versioning mode (default: disabled)"),
];

#[derive(Clone, PartialEq, Eq, Debug)]
pub enum DumpDisasm {
    // Dump to stdout
    Stdout,
    // Dump to "yjit_{pid}.log" file under the specified directory
    File(String),
}

/// Macro to get an option value by name
macro_rules! get_option {
    // Unsafe is ok here because options are initialized
    // once before any Ruby code executes
    ($option_name:ident) => {
        {
            // make this a statement since attributes on expressions are experimental
            #[allow(unused_unsafe)]
            let ret = unsafe { OPTIONS.$option_name };
            ret
        }
    };
}
pub(crate) use get_option;

/// Macro to reference an option value by name; we assume it's a cloneable type like String or an Option of same.
macro_rules! get_option_ref {
    // Unsafe is ok here because options are initialized
    // once before any Ruby code executes
    ($option_name:ident) => {
        unsafe { &($crate::options::OPTIONS.$option_name) }
    };
}
pub(crate) use get_option_ref;

/// Expected to receive what comes after the third dash in "--yjit-*".
/// Empty string means user passed only "--yjit". C code rejects when
/// they pass exact "--yjit-".
pub fn parse_option(str_ptr: *const std::os::raw::c_char) -> Option<()> {
    let c_str: &CStr = unsafe { CStr::from_ptr(str_ptr) };
    let opt_str: &str = c_str.to_str().ok()?;
    //println!("{}", opt_str);

    // Split the option name and value strings
    // Note that some options do not contain an assignment
    let parts = opt_str.split_once('=');
    let (opt_name, opt_val) = match parts {
        Some((before_eq, after_eq)) => (before_eq, after_eq),
        None => (opt_str, ""),
    };

    // Match on the option name and value strings
    match (opt_name, opt_val) {
        ("", "") => (), // Simply --yjit

        ("exec-mem-size", _) => match opt_val.parse::<usize>() {
            Ok(n) => {
                if n == 0 || n > 2 * 1024 * 1024 {
                    return None
                }

                // Convert from MiB to bytes internally for convenience
                unsafe { OPTIONS.exec_mem_size = n * 1024 * 1024 }
            }
            Err(_) => {
                return None;
            }
        },

        ("call-threshold", _) => match opt_val.parse() {
            Ok(n) => unsafe { OPTIONS.call_threshold = n },
            Err(_) => {
                return None;
            }
        },

        ("cold-threshold", _) => match opt_val.parse() {
            Ok(n) => unsafe { OPTIONS.cold_threshold = n },
            Err(_) => {
                return None;
            }
        },

        ("max-versions", _) => match opt_val.parse() {
            Ok(n) => unsafe { OPTIONS.max_versions = n },
            Err(_) => {
                return None;
            }
        },

        ("pause", "") => unsafe {
            OPTIONS.pause = true;
        },

        ("disable-code-gc", "") => unsafe {
            OPTIONS.disable_code_gc = true;
        }

        ("temp-regs", _) => match opt_val.parse() {
            Ok(n) => {
                assert!(n <= TEMP_REGS.len(), "--yjit-temp-regs must be <= {}", TEMP_REGS.len());
                unsafe { OPTIONS.num_temp_regs = n }
            }
            Err(_) => {
                return None;
            }
        },

        ("dump-disasm", _) => match opt_val {
            "" => unsafe { OPTIONS.dump_disasm = Some(DumpDisasm::Stdout) },
            directory => {
                let pid = std::process::id();
                let path = format!("{directory}/yjit_{pid}.log");
                println!("YJIT disasm dump: {path}");
                unsafe { OPTIONS.dump_disasm = Some(DumpDisasm::File(path)) }
            }
         },

        ("dump-iseq-disasm", _) => unsafe {
            OPTIONS.dump_iseq_disasm = Some(opt_val.to_string());
        },

        ("greedy-versioning", "") => unsafe { OPTIONS.greedy_versioning = true },
        ("no-type-prop", "") => unsafe { OPTIONS.no_type_prop = true },
        ("stats", _) => match opt_val {
            "" => unsafe { OPTIONS.gen_stats = true },
            "quiet" => {
                unsafe { OPTIONS.gen_stats = true }
                unsafe { OPTIONS.print_stats = false }
            },
            _ => {
                return None;
            }
        },
        ("trace-exits", "") => unsafe { OPTIONS.gen_trace_exits = true; OPTIONS.gen_stats = true; OPTIONS.trace_exits_sample_rate = 0 },
        ("trace-exits-sample-rate", sample_rate) => unsafe { OPTIONS.gen_trace_exits = true; OPTIONS.gen_stats = true; OPTIONS.trace_exits_sample_rate = sample_rate.parse().unwrap(); },
        ("dump-insns", "") => unsafe { OPTIONS.dump_insns = true },
        ("verify-ctx", "") => unsafe { OPTIONS.verify_ctx = true },

        // Option name not recognized
        _ => {
            return None;
        }
    }

    // before we continue, check that sample_rate is either 0 or a prime number
    let trace_sample_rate = unsafe { OPTIONS.trace_exits_sample_rate };
    if trace_sample_rate > 1 {
        let mut i = 2;
        while i*i <= trace_sample_rate {
            if trace_sample_rate % i == 0 {
                println!("Warning: using a non-prime number as your sampling rate can result in less accurate sampling data");
                return Some(());
            }
            i += 1;
        }
    }

    // dbg!(unsafe {OPTIONS});

    // Option successfully parsed
    return Some(());
}

/// Print YJIT options for `ruby --help`. `width` is width of option parts, and
/// `columns` is indent width of descriptions.
#[no_mangle]
pub extern "C" fn rb_yjit_show_usage(help: c_int, highlight: c_int, width: c_uint, columns: c_int) {
    for &(name, description) in YJIT_OPTIONS.iter() {
        extern "C" {
            fn ruby_show_usage_line(name: *const c_char, secondary: *const c_char, description: *const c_char,
                                    help: c_int, highlight: c_int, width: c_uint, columns: c_int);
        }
        let name = CString::new(name).unwrap();
        let description = CString::new(description).unwrap();
        unsafe { ruby_show_usage_line(name.as_ptr(), null(), description.as_ptr(), help, highlight, width, columns) }
    }
}
