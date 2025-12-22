// or PDE
typedef u32 pte;// 0..11位为其他位，12..31为baseaddr

#define PG_P 1 // 页存在属性位
#define PG_RWR 0 // R/W 属性位值, 读/执行
#define PG_RWW 2 // R/W 属性位值, 读/写/执行
#define PG_USS 0 // U/S 属性位值, 系统级
#define PG_USU 4 // U/S 属性位值, 用户级

/*
    模仿proc.c的va2la，都用void* 代表地址
*/
void* la2pa(pte* pagedir, void* la);

void map(pte* pagedir, void *la, FrameTracker *ft);
void kmap(pte* pagedir, void *la, FrameTracker *ft);



FrameTracker *unmap(pte* pagedir, void *la);

pte* new_page_table();


pte *kget_final_entry(pte *pagedir, void *la);
pte *dbg_first_entry(pte *pagedir, void *la);