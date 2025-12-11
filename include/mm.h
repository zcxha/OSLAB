#include "type.h"

// ; 传入32位虚拟地址，返回物理地址
// ; 出错则返回-1
int VAToPA(u32 va);

// ; 输入要分配的物理帧数量，以及对应的帧的物理页号存储指针数组
// ; 失败返回-1，成功返回0
int alloc_pages(u32 num, u32 *ptr);

// ; p为物理页号数组基地址，num为要释放的页数
void free_pages(u32 num, u32 *ptr);

// ; 将va映射到pa
void map(u32 va, u32 pa);

// ; u32 unmap(u32 va)
// ; 输入va，输出unmap之后的pa
u32 unmap(u32 va);

// 获取整个bitmap，p指向一个4元素数组，这样一共就128位
void get_bitmap(u32 *p);

// 初始化128位bitmap为全0
void init_bitmap();