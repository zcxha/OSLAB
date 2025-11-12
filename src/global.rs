/// global.rs
/// 此处存放全局变量

use crate::config::{GDT_SIZE, IDT_SIZE};
use crate::protect::{DESCRIPTOR, GATE, DT_PTR_UNION};

// 注意到这种形式在汇编中是定义这样一段GDT_PTR: .zero 6
// C中的数组，汇编形式是 一个Label：.zero 6
#[unsafe(no_mangle)]
pub static mut GDT_PTR: DT_PTR_UNION = DT_PTR_UNION{raw: [0; 6]};
// pub static mut GDT_PTR: [u8; 6] = [0; 6];

#[unsafe(no_mangle)]
pub static mut IDT_PTR: DT_PTR_UNION = DT_PTR_UNION{raw: [0; 6]};

#[unsafe(no_mangle)]
pub static mut DISP_POS: u32 = 1;

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
pub static mut IDT: [GATE; IDT_SIZE] = [GATE {
    offset_low: 0,
    selector: 0,
    dcount: 0,
    attr: 0,
    offset_high: 0,
}; IDT_SIZE];