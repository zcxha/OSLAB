// main.rs
#![no_std]
#![no_main]

pub mod config;
use core::{arch::asm, panic::PanicInfo, ptr::read_unaligned};

use crate::config::GDT_SIZE;

#[repr(C)]
#[derive(Clone, Copy)]
pub struct DESCRIPTOR {
    limit_low: u16,       /* Limit */
    base_low: u16,        /* Base */
    base_mid: u8,         /* Base */
    attr1: u8,            /* P(1) DPL(2) DT(1) TYPE(4) */
    limit_high_attr2: u8, /* G(1) D(1) 0(1) AVL(1) LimitHign(4) */
    base_high: u8,        /* Base */
}

// 注意到这种形式在汇编中是定义这样一段GDT_PTR: .zero 6
// C中的数组，汇编形式是 一个Label：.zero 6
#[unsafe(no_mangle)]
pub static mut GDT_PTR: [u8; 6] = [0; 6];
#[unsafe(no_mangle)]
pub static mut DISP_POS: u32 = 0;
#[unsafe(no_mangle)]
pub static mut GDT: [DESCRIPTOR; GDT_SIZE] = [DESCRIPTOR {
    limit_low: 0,
    base_low: 0,
    base_mid: 0,
    attr1: 0,
    limit_high_attr2: 0,
    base_high: 0,
}; GDT_SIZE];

#[unsafe(no_mangle)]
pub extern "C" fn rust_main() {
    init_var();
    unsafe extern "C" {
        fn memcpy(p_dst: *const [DESCRIPTOR; GDT_SIZE], p_src: u32, size: u16);
        fn disp_str(pszInfo: *const u8);
    }

	

    unsafe {

		let lim: u16 = ((GDT_PTR[1] as u16) << 8) + (GDT_PTR[0] as u16);
		let base: u32 = ((GDT_PTR[5] as u32) << 24)
			+ ((GDT_PTR[4] as u32) << 16)
			+ ((GDT_PTR[3] as u32) << 8)
			+ (GDT_PTR[2] as u32);
        memcpy(&raw const GDT, base, lim + 1);

		let newbase = &raw const GDT[0] as u32;
		let newlim: u16 = (GDT_SIZE * size_of::<DESCRIPTOR>()) as u16 - 1;
		
		GDT_PTR[0] = newlim as u8;GDT_PTR[1] = (newlim >> 8) as u8;
		GDT_PTR[2] = newbase as u8; GDT_PTR[3] = (newbase >> 8) as u8; GDT_PTR[4] = (newbase >> 16) as u8; GDT_PTR[5] = (newbase >> 24) as u8;

        let str = "hello\0".as_ptr();
        disp_str(str);
    }
    return;
}

fn init_var() {
    unsafe {
        DISP_POS = 0;
    };
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
