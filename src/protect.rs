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
