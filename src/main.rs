// main.rs
#![no_std]
#![no_main]

pub mod config;
pub mod consts;
pub mod global;
pub mod i8259;
pub mod interrupts;
pub mod protect;
pub mod scrout;
pub mod testmm;

use crate::testmm::*;
use crate::config::*;
use crate::global::*;
use crate::i8259::init_8259A;
use crate::interrupts::*;
use crate::protect::*;
use crate::scrout::print;
use crate::scrout::print_int;
use core::arch::asm;
use core::panic::PanicInfo;


// extern assembly func
unsafe extern "C" {
    fn memcpy(p_dst: *const [DESCRIPTOR; GDT_SIZE], p_src: u32, size: u16);
}


#[unsafe(no_mangle)]
pub extern "C" fn rust_main() {
    init_var();

    replace_gdt();
    init_idt();
	print_int(348);
    print(c"hello");

	test_mm();
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
