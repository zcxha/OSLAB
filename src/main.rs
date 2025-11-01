// main.rs
#![no_std]
#![no_main]

pub mod config;
pub mod r#const;
pub mod global;
pub mod i8259;
pub mod interrupts;
pub mod protect;

use crate::config::*;
use crate::global::*;
use crate::i8259::init_8259A;
use crate::interrupts::*;
use crate::protect::*;
use core::arch::asm;
use core::panic::PanicInfo;

// extern assembly func
unsafe extern "C" {
    fn memcpy(p_dst: *const [DESCRIPTOR; GDT_SIZE], p_src: u32, size: u16);
    fn disp_str(pszInfo: *const u8);
    fn disp_color_str(Info: *const u8, color: i32);
}

pub const HEX_CHARS: &[u8; 16] = b"0123456789abcdef";
pub fn u32_to_hex_buf_lower(value: u32, buf: &mut [u8]) {
    for i in 0..8 {
        let shift = (7 - i) * 4;
        let nibble = ((value >> shift) & 0xF) as usize;
        if let Some(c) = HEX_CHARS.get(nibble) {
			if let Some(x) = buf.get_mut(i + 2) {
				*x = *c;
			}
        }
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn rust_main() {
    init_var();
    replace_gdt();
    // init_idt();
    unsafe {
        let mut buf: [u8; 11] = [42; 11];
		asm!("xchg bx, bx");
		buf[0] = b'0';
		buf[1] = b'x';
		buf[10] = 0;
		asm!("xchg bx, bx");
        u32_to_hex_buf_lower(333, &mut buf);
        disp_str(buf.as_ptr());

		disp_str("\n\0".as_ptr());

		disp_str("hello\0".as_ptr());
    }
    return;
}

fn init_idt() {
    unsafe {
        IDT_PTR.dt_ptr.base = &raw const IDT as u32;
        IDT_PTR.dt_ptr.lim = (IDT_SIZE * size_of::<GATE>()) as u16 - 1;
    }

    init_8259A();
    init_int();
}

fn replace_gdt() {
    let lim = unsafe { GDT_PTR.dt_ptr.lim };
    let base = unsafe { GDT_PTR.dt_ptr.base };
    unsafe { memcpy(&raw const GDT, base, lim + 1) };
    let newbase = &raw const GDT as u32;
    let newlim = (GDT_SIZE * size_of::<DESCRIPTOR>()) as u16 - 1;
    unsafe { GDT_PTR.dt_ptr.base = newbase };
    unsafe { GDT_PTR.dt_ptr.lim = newlim };
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
