// main.rs
#![no_std]
#![no_main]

pub mod config;
pub mod global;
pub mod protect;

use crate::config::*;
use crate::global::*;
use crate::protect::*;
use core::arch::asm;
use core::panic::PanicInfo;

// extern assembly func
unsafe extern "C" {
    fn memcpy(p_dst: *const [DESCRIPTOR; GDT_SIZE], p_src: u32, size: u16);
    fn disp_str(pszInfo: *const u8);
	fn disp_color_str(Info: *const u8, color: i32);
}

#[unsafe(no_mangle)]
pub extern "C" fn rust_main() {
    init_var();
	replace_gdt();

    unsafe {
        let str = "hello\0".as_ptr();
        disp_str(str);
    }
    return;
}

fn replace_gdt()
{
	let lim = unsafe { GDT_PTR.gdt_ptr.lim };
	let base = unsafe { GDT_PTR.gdt_ptr.base };
	unsafe { memcpy(&raw const GDT, base, lim + 1) };
	let newbase = &raw const GDT as u32;
	let newlim = (GDT_SIZE * size_of::<DESCRIPTOR>()) as u16 - 1;
	unsafe { GDT_PTR.gdt_ptr.base = newbase };
	unsafe { GDT_PTR.gdt_ptr.lim = newlim };
}

// fn replace_gdt() {
//     unsafe {
//         let lim: u16 = ((GDT_PTR[1] as u16) << 8) + (GDT_PTR[0] as u16);
//         let base: u32 = ((GDT_PTR[5] as u32) << 24)
//             + ((GDT_PTR[4] as u32) << 16)
//             + ((GDT_PTR[3] as u32) << 8)
//             + (GDT_PTR[2] as u32);
//         memcpy(&raw const GDT, base, lim + 1);

//         let newbase = &raw const GDT[0] as u32;
//         let newlim: u16 = (GDT_SIZE * size_of::<DESCRIPTOR>()) as u16 - 1;

//         GDT_PTR[0] = newlim as u8;
//         GDT_PTR[1] = (newlim >> 8) as u8;
//         GDT_PTR[2] = newbase as u8;
//         GDT_PTR[3] = (newbase >> 8) as u8;
//         GDT_PTR[4] = (newbase >> 16) as u8;
//         GDT_PTR[5] = (newbase >> 24) as u8;
//     }
// }

fn init_var() {
    unsafe {
        DISP_POS = 0;
    };
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
