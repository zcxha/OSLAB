use core::arch::asm;

use crate::r#const::{PRIVILEGE_KRNL, PRIVILEGE_USER};
use crate::global::{DISP_POS, IDT};
use crate::{disp_color_str, disp_str,  protect::*};

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
    unsafe { DISP_POS = 0 };

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
        PRIVILEGE_USER,
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
    let base: u32 = &raw const handler as u32;
    // println!("addr:{}", base);
    unsafe {
        IDT[vector as usize].offset_low = base as u16;
        IDT[vector as usize].selector = SELECTOR_KERN_CS as u16;
        IDT[vector as usize].dcount = 0;
        IDT[vector as usize].attr = desc_type | (privilege << 5);
        IDT[vector as usize].offset_high = (base >> 16) as u16;
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn exception_handler(vec_no: u32, err_code: u32, eip: u32, cs: u32, eflags: u32) {
    let err_msg = [
        "#DE Divide Error",
        "#DB RESERVED",
        "—  NMI Interrupt",
        "#BP Breakpoint",
        "#OF Overflow",
        "#BR BOUND Range Exceeded",
        "#UD Invalid Opcode (Undefined Opcode)",
        "#NM Device Not Available (No Math Coprocessor)",
        "#DF Double Fault",
        "    Coprocessor Segment Overrun (reserved)",
        "#TS Invalid TSS",
        "#NP Segment Not Present",
        "#SS Stack-Segment Fault",
        "#GP General Protection",
        "#PF Page Fault",
        "—  (Intel reserved. Do not use.)",
        "#MF x87 FPU Floating-Point Error (Math Fault)",
        "#AC Alignment Check",
        "#MC Machine Check",
        "#XF SIMD Floating-Point Exception",
    ];

    let text_color = 0x74;

    unsafe { DISP_POS = 0 };
    for i in 0..80 * 5 {
        unsafe { disp_str("\n".as_ptr()) };
    }
    unsafe { DISP_POS = 0 };

    // printc!(text_color, "Exception! --> ");
    // 用这种方法避免编译器bound_check
    if let Some(msg) = err_msg.get(vec_no as usize) {
    } else {
    }
    // printc!(text_color, "{}", err_msg[vec_no as usize]);
    // printlnc!(text_color, "");
    // printlnc!(text_color, "");
    // printlnc!(text_color, "EFLAGS:{}", eflags);
    // printc!(text_color, "CS: {}", cs);
    // printc!(text_color, "EIP: {}", eip);

    if err_code != 0xFFFFFFFF {
        // printc!(text_color, "Error code: {}", err_code);
    }
}
