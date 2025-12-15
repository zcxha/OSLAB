/*
    这个文件定义一些内存固定位置
*/

#define PAGE_DIR_BASE    0x20000000
#define PAGE_TABLE_BASE  0x20001000
/*
    OS controls all heap.
    this is 256M heap area.
*/
#define HEAP_BASE        0x8000000
#define HEAP_SIZE        0x10000000