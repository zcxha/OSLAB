use core::arch::asm;
use core::ffi::CStr;
use core::ptr::write_volatile;

use crate::consts::{PRIVILEGE_KRNL, PRIVILEGE_USER};
use crate::global::{DISP_POS, IDT};
use crate::protect::*;
use crate::scrout::{print, print_int};

unsafe extern "C" {
    fn divide_error();
    fn single_step_exception();
    fn nmi();
    fn breakpoint_exception();
    fn overflow();
    fn bounds_check();
    fn inval_opcode();
    fn copr_not_available();
    fn double_fault();
    fn copr_seg_overrun();
    fn inval_tss();
    fn segment_not_present();
    fn stack_exception();
    fn general_protection();
    fn page_fault();
    fn copr_error();
    fn hwint00();
    fn hwint01();
    fn hwint02();
    fn hwint03();
    fn hwint04();
    fn hwint05();
    fn hwint06();
    fn hwint07();
    fn hwint08();
    fn hwint09();
    fn hwint10();
    fn hwint11();
    fn hwint12();
    fn hwint13();
    fn hwint14();
    fn hwint15();
}

pub fn init_int() {
    // 全部初始化成中断门(没有陷阱门)
    init_idt_desc(INT_VECTOR_DIVIDE, DA_386IGate, divide_error, PRIVILEGE_KRNL);

    init_idt_desc(
        INT_VECTOR_DEBUG,
        DA_386IGate,
        single_step_exception,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(INT_VECTOR_NMI, DA_386IGate, nmi, PRIVILEGE_KRNL);

    init_idt_desc(
        INT_VECTOR_BREAKPOINT,
        DA_386IGate,
        breakpoint_exception,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(INT_VECTOR_OVERFLOW, DA_386IGate, overflow, PRIVILEGE_USER);

    init_idt_desc(INT_VECTOR_BOUNDS, DA_386IGate, bounds_check, PRIVILEGE_KRNL);

    init_idt_desc(
        INT_VECTOR_INVAL_OP,
        DA_386IGate,
        inval_opcode,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_COPROC_NOT,
        DA_386IGate,
        copr_not_available,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_DOUBLE_FAULT,
        DA_386IGate,
        double_fault,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_COPROC_SEG,
        DA_386IGate,
        copr_seg_overrun,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(INT_VECTOR_INVAL_TSS, DA_386IGate, inval_tss, PRIVILEGE_KRNL);

    init_idt_desc(
        INT_VECTOR_SEG_NOT,
        DA_386IGate,
        segment_not_present,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_STACK_FAULT,
        DA_386IGate,
        stack_exception,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_PROTECTION,
        DA_386IGate,
        general_protection,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_PAGE_FAULT,
        DA_386IGate,
        page_fault,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(
        INT_VECTOR_COPROC_ERR,
        DA_386IGate,
        copr_error,
        PRIVILEGE_KRNL,
    );

    init_idt_desc(INT_VECTOR_IRQ0 + 0, DA_386IGate, hwint00, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 1, DA_386IGate, hwint01, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 2, DA_386IGate, hwint02, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 3, DA_386IGate, hwint03, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 4, DA_386IGate, hwint04, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 5, DA_386IGate, hwint05, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 6, DA_386IGate, hwint06, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ0 + 7, DA_386IGate, hwint07, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 0, DA_386IGate, hwint08, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 1, DA_386IGate, hwint09, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 2, DA_386IGate, hwint10, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 3, DA_386IGate, hwint11, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 4, DA_386IGate, hwint12, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 5, DA_386IGate, hwint13, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 6, DA_386IGate, hwint14, PRIVILEGE_KRNL);

    init_idt_desc(INT_VECTOR_IRQ8 + 7, DA_386IGate, hwint15, PRIVILEGE_KRNL);
}

fn init_idt_desc(vector: u8, desc_type: u8, handler: unsafe extern "C" fn(), privilege: u8) {
    unsafe {
        let base: u32 = handler as usize as u32;
        IDT[vector as usize].offset_low = base as u16;
        IDT[vector as usize].selector = SELECTOR_KERN_CS as u16;
        IDT[vector as usize].dcount = 0;
        IDT[vector as usize].attr = desc_type | (privilege << 5);
        IDT[vector as usize].offset_high = (base >> 16) as u16;
    }
}

#[unsafe(no_mangle)]
pub fn exception_handler(vec_no: u32, err_code: u32, eip: u32, cs: u32, eflags: u32) {
    let err_msg = [
        c"#DE Divide Error",
        c"#DB RESERVED",
        c"—  NMI Interrupt",
        c"#BP Breakpoint",
        c"#OF Overflow",
        c"#BR BOUND Range Exceeded",
        c"#UD Invalid Opcode (Undefined Opcode)",
        c"#NM Device Not Available (No Math Coprocessor)",
        c"#DF Double Fault",
        c"    Coprocessor Segment Overrun (reserved)",
        c"#TS Invalid TSS",
        c"#NP Segment Not Present",
        c"#SS Stack-Segment Fault",
        c"#GP General Protection",
        c"#PF Page Fault",
        c"—  (Intel reserved. Do not use.)",
        c"#MF x87 FPU Floating-Point Error (Math Fault)",
        c"#AC Alignment Check",
        c"#MC Machine Check",
        c"#XF SIMD Floating-Point Exception",
    ];

    let text_color: i32 = 0x74;
    // todo: 打印会花屏
    unsafe {
        DISP_POS = 0;
    }

    for i in 0..(80 * 5) {
        print(c" ");
    }
    unsafe {
        DISP_POS = 0;
    }

    print(c"Exception! --> ");
    // 用这种方法避免编译器bound_check
    if let Some(msg) = err_msg.get(vec_no as usize) {
        print(msg);
    }
    print(c"EFLAGS: ");
    print(c"\n");
    print(c"\n");
    print_int(eflags);
    print(c"CS: ");
    print_int(cs);
    print(c"EIP: ");
    print_int(eip);

    if err_code != 0xFFFFFFFF {
        print(c"Err code: ");
        print_int(err_code);
    }
}
