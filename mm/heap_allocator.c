#include "type.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "proto.h"
#include "mm/aspace.h"
#include "mm/buddy_system.h"
#include "mm/frame_allocator.h"
#include "mm/page_table.h"
#include "mm/heap_allocator.h"
#include "global.h"

/* 
    分配大小的内存 
    size限制：加上ListNode的大小不能超过512B
*/
void *malloc(u32 __size)
{
    Layout mm_layout;
    mm_layout.size = __size + sizeof(ListNode);

    return buddy_alloc(mm_layout) + sizeof(ListNode);
}

/*
    free 堆内存
*/
void free(void *p)
{
    p -= sizeof(ListNode);
    buddy_dealloc(p);
}