/// This function is called from C code
#[no_mangle]
pub extern "C" fn init_yjit() {
    println!("Entering init_yjit() function");
}
