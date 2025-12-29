/*
    这个文件定义一些内存固定位置
*/

#define KERNEL_SECURITY_AREA 0x4000

#define KERNEL_BASE 0x100000

#define PAGE_DIR_BASE    0x20000000
#define PAGE_TABLE_BASE  0x20001000
/*
    OS controls all heap.
    this is 256M heap area.
*/
#define HEAP_BASE        0x8000000
#define HEAP_SIZE        0x10000000

#define MEM_SIZE 0x40000000

/* 是否开启虚拟内存 */
#define vmem_en 1