/// protect.rs
/// 此处存放保护模式相关的数据结构和体系结构常数和各种系统运行相关的常数


/// Descriptor Table PTR Union
#[repr(C)]
pub union DT_PTR_UNION {
    pub raw: [u8; 6],
    pub dt_ptr: DT_PTR_STRUCT,
}
/// 注意此处的对齐
/// 若不使用repr(C) 结构体内存布局是不确定的
#[repr(C, packed(2))]
#[derive(Clone, Copy)]
pub struct DT_PTR_STRUCT {
    pub lim: u16,
    pub base: u32,
}

#[repr(C,packed(2))]
#[derive(Clone, Copy)]
pub struct DESCRIPTOR {
    pub limit_low: u16,       /* Limit */
    pub base_low: u16,        /* Base */
    pub base_mid: u8,         /* Base */
    pub attr1: u8,            /* P(1) DPL(2) DT(1) TYPE(4) */
    pub limit_high_attr2: u8, /* G(1) D(1) 0(1) AVL(1) LimitHign(4) */
    pub base_high: u8,        /* Base */
}

#[repr(C,packed(2))]
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
    pub offset_high: u16,
}

/* GDT */
/* 描述符索引 */
pub const INDEX_DUMMY: usize = 0; // ┓
pub const INDEX_FLAT_C: usize = 1; // ┣ LOADER 里面已经确定了的.
pub const INDEX_FLAT_RW: usize = 2; // ┃
pub const INDEX_VIDEO: usize = 3; // ┛
/* 选择子 */
pub const SELECTOR_DUMMY: usize = 0;
pub const SELECTOR_FLAT_C: usize = 0x08;
pub const SELECTOR_FLAT_RW: usize = 0x10;
pub const SELECTOR_VIDEO: usize = 0x18 + 3;
pub const SELECTOR_TSS: usize = 0x20;

pub const SELECTOR_KERN_CS: usize = SELECTOR_FLAT_C;
pub const SELECTOR_KERN_DS: usize = SELECTOR_FLAT_RW;


/* 描述符类型值说明 */
pub const DA_32: usize = 0x4000; /* 32 位段				*/
pub const DA_LIMIT_4K: usize = 0x8000; /* 段界限粒度为 4K 字节			*/
pub const DA_DPL0: u8 = 0x00; /* DPL = 0				*/
pub const DA_DPL1: u8 = 0x20; /* DPL = 1				*/
pub const DA_DPL2: u8 = 0x40; /* DPL = 2				*/
pub const DA_DPL3: u8 = 0x60; /* DPL = 3				*/
/* 存储段描述符类型值说明 */
pub const DA_DR: u8 = 0x90; /* 存在的只读数据段类型值		*/
pub const DA_DRW: u8 = 0x92; /* 存在的可读写数据段属性值		*/
pub const DA_DRWA: u8 = 0x93; /* 存在的已访问可读写数据段类型值	*/
pub const DA_C: u8 = 0x98; /* 存在的只执行代码段属性值		*/
pub const DA_CR: u8 = 0x9A; /* 存在的可执行可读代码段属性值		*/
pub const DA_CCO: u8 = 0x9C; /* 存在的只执行一致代码段属性值		*/
pub const DA_CCOR: u8 = 0x9E; /* 存在的可执行可读一致代码段属性值	*/
/* 系统段描述符类型值说明 */
pub const DA_LDT: u8 = 0x82; /* 局部描述符表段类型值			*/
pub const DA_TaskGate: u8 = 0x85; /* 任务门类型值				*/
pub const DA_386TSS: u8 = 0x89; /* 可用 386 任务状态段类型值		*/
pub const DA_386CGate: u8 = 0x8C; /* 386 调用门类型值			*/
pub const DA_386IGate: u8 = 0x8E; /* 386 中断门类型值			*/
pub const DA_386TGate: u8 = 0x8F; /* 386 陷阱门类型值			*/

/* 中断向量 */
pub const INT_VECTOR_DIVIDE: u8 = 0x0;
pub const INT_VECTOR_DEBUG: u8 = 0x1;
pub const INT_VECTOR_NMI: u8 = 0x2;
pub const INT_VECTOR_BREAKPOINT: u8 = 0x3;
pub const INT_VECTOR_OVERFLOW: u8 = 0x4;
pub const INT_VECTOR_BOUNDS: u8 = 0x5;
pub const INT_VECTOR_INVAL_OP: u8 = 0x6;
pub const INT_VECTOR_COPROC_NOT: u8 = 0x7;
pub const INT_VECTOR_DOUBLE_FAULT: u8 = 0x8;
pub const INT_VECTOR_COPROC_SEG: u8 = 0x9;
pub const INT_VECTOR_INVAL_TSS: u8 = 0xA;
pub const INT_VECTOR_SEG_NOT: u8 = 0xB;
pub const INT_VECTOR_STACK_FAULT: u8 = 0xC;
pub const INT_VECTOR_PROTECTION: u8 = 0xD;
pub const INT_VECTOR_PAGE_FAULT: u8 = 0xE;
pub const INT_VECTOR_COPROC_ERR: u8 = 0x10;

/* 中断向量 */
pub const INT_VECTOR_IRQ0: u8 = 0x20;
pub const INT_VECTOR_IRQ8: u8 = 0x28;

pub const INT_M_CTL: u16 = 0x20;
pub const INT_M_CTLMASK: u16 = 0x21;
pub const INT_S_CTL: u16 = 0xA0;
pub const INT_S_CTLMASK: u16 = 0xA1;
/* 权限 */
pub const PRIVILEGE_KRNL: u8 = 0;
pub const PRIVILEGE_TASK: u8 = 1;
pub const PRIVILEGE_USER: u8 = 3;
