// main.rs
#![no_std]
#![no_main]

use core::panic::PanicInfo;

static HELLO: &[u8] = b"Hello lslRust!123";

#[unsafe(no_mangle)]
pub static mut GDT_PTR: &mut [u8] = &mut [0, 0, 0, 0, 0, 0];

#[unsafe(no_mangle)]
pub extern "C" fn rust_main() -> ! {
    let vga_buffer = 0xb8000 as *mut u8;

    // for (i, &byte) in HELLO.iter().enumerate() {
    //     unsafe {
    //         *vga_buffer.offset(i as isize * 2) = byte;
    //         *vga_buffer.offset(i as isize * 2 + 1) = 0xb;
    //     }
    // }

    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
