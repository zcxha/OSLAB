use core::arch::asm;

use crate::r#const::*;
use crate::config::*;
use crate::disp_str;

unsafe extern "C" {
    fn in_byte(port: u16) -> u8;
    fn out_byte(port: u16, value: u8);
}

pub fn init_8259A() {
	unsafe {
    /* Master 8259, ICW1. */
    out_byte(INT_M_CTL, 0x11);

    /* Slave  8259, ICW1. */
    out_byte(INT_S_CTL, 0x11);

    /* Master 8259, ICW2. 设置 '主8259' 的中断入口地址为 0x20. */
    out_byte(INT_M_CTLMASK, INT_VECTOR_IRQ0);

    /* Slave  8259, ICW2. 设置 '从8259' 的中断入口地址为 0x28 */
    out_byte(INT_S_CTLMASK, INT_VECTOR_IRQ8);

    /* Master 8259, ICW3. IR2 对应 '从8259'. */
    out_byte(INT_M_CTLMASK, 0x4);

    /* Slave  8259, ICW3. 对应 '主8259' 的 IR2. */
    out_byte(INT_S_CTLMASK, 0x2);

    /* Master 8259, ICW4. */
    out_byte(INT_M_CTLMASK, 0x1);
    /* Slave  8259, ICW4. */
    out_byte(INT_S_CTLMASK, 0x1);

    /* Master 8259, OCW1.  */
    out_byte(INT_M_CTLMASK, 0xFF);

    /* Slave  8259, OCW1.  */
    out_byte(INT_S_CTLMASK, 0xFF);
	}
}

#[unsafe(no_mangle)]
pub extern "C" fn spurious_irq(irq: u32)
{
	// println!("spurious_irq: {}", irq);
	unsafe { disp_str("spurious_irq".as_ptr()) };
	unsafe { out_byte(INT_M_CTL, 0x20) };
}