#[repr(C)]
pub union GDT_PTR_UNION {
    pub raw: [u8; 6],
    pub gdt_ptr: GDT_PTR_STRUCT,
}

/// 注意此处的对齐
/// 若不使用repr(C) 结构体内存布局是不确定的
#[repr(C,packed(2))]
#[derive(Clone, Copy)]
pub struct GDT_PTR_STRUCT {
	pub lim: u16,
	pub base: u32
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct DESCRIPTOR {
    pub limit_low: u16,       /* Limit */
    pub base_low: u16,        /* Base */
    pub base_mid: u8,         /* Base */
    pub attr1: u8,            /* P(1) DPL(2) DT(1) TYPE(4) */
    pub limit_high_attr2: u8, /* G(1) D(1) 0(1) AVL(1) LimitHign(4) */
    pub base_high: u8,        /* Base */
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct GATE {
    pub offset_low: u16,
    pub selector: u16,

    /** 该字段只在调用门描述符中有效。如果在利用
    调用门调用子程序时引起特权级的转换和堆栈
    的改变，需要将外层堆栈中的参数复制到内层
    堆栈。该双字计数字段就是用于说明这种情况
    发生时，要复制的双字参数的数量。*/
    pub dcount: u8,

    /** P(1) DPL(2) DT(1) TYPE(4) */
    pub attr: u8,
    pub offset_hign: u16,
}
