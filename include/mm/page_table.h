// or PDE
typedef struct pte {
    u32 paddr; // 0..11位为其他位，12..31为baseaddr
}pte;

#define PG_P 1 // 页存在属性位
#define PG_RWR 0 // R/W 属性位值, 读/执行
#define PG_RWW 2 // R/W 属性位值, 读/写/执行
#define PG_USS 0 // U/S 属性位值, 系统级
#define PG_USU 4 // U/S 属性位值, 用户级
// or pd
typedef struct pte* pgtable_t;

/*
    模仿proc.c的va2la，都用void* 代表地址
*/
void* la2pa(void* la);

void map(void *la, FrameTracker *ft);

FrameTracker *unmap(void *la);