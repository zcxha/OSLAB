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
#include "mm/frame_allocator.h"
#include "mm/page_table.h"
#include "global.h"

const u32 PTECNT = 1024;


pte* new_page_table()
{
    FrameTracker *ft = frame_alloc();
    ft->count++;
    pte* new_pgdir = ft->phybase;
    for (int i = 0; i < 1024 /* 一个页目录1024项 */; i++)
    {
        /* 初始化二级页表 */
        FrameTracker *ft = frame_alloc();
        for (int j = 0; j < FRAME_SIZE; j++)
        {
            /* 写0 */
            *((u8 *)ft->phybase + j) = 0;
        }
        
        pte * pd_entry = (new_pgdir + i);
        *pd_entry = ft->phybase | PG_USU | PG_P | PG_RWW;
    }
    return new_pgdir;
}

/*
    TODO: 只有基本存在检查，后续应该要有权限检查
*/

/*
    获得二级页表的最后一级页表的页表项
*/
pte *get_final_entry(pte *pagedir, void *la)
{
    u32 pdidx = ((u32)la >> 22);
    u32 ptidx = (((u32)la) & 0b1111111111000000000000) >> 12;
    pte first_level_entry = *(pagedir + pdidx);
    assert(first_level_entry & PG_P);

    pte *second_level_dir = first_level_entry & 0xFFFFF000;
    pte *second_level_entry = second_level_dir + ptidx;
    return second_level_entry;
}

/*
    获得二级页表的最后一级页表的页表项
*/
pte *kget_final_entry(pte *pagedir, void *la)
{
    u32 pdidx = ((u32)la >> 22);
    u32 ptidx = (((u32)la) & 0b1111111111000000000000) >> 12;
    pte first_level_entry = *(pagedir + pdidx);
    // assert(first_level_entry & PG_P);

    pte *second_level_dir = first_level_entry & 0xFFFFF000;
    pte *second_level_entry = second_level_dir + ptidx;
    return second_level_entry;
}

void *la2pa(pte* pagedir, void *la)
{
    // 对齐
    assert(((u32)la & 0xFFF) == 0);
    pte *final_entry = get_final_entry(pagedir, la);
    assert(*final_entry & PG_P);
    return (*final_entry & 0xFFFFF000);
}

/*
    the la here is Linear Address, not Logical Address.
    The source code on book is not so tidy...
*/

/*
    map linear address to FrameTracker which has been allocated.
*/
void map(pte* pagedir, void *la, FrameTracker *ft)
{
    assert(((u32)la & 0xFFF) == 0);
    assert(ft->in_use);

    ft->count++;

    pte *final_entry = get_final_entry(pagedir, la);
    // 默认给这三个权限
    *final_entry = ft->phybase | PG_P | PG_RWW | PG_USU;
}

/*
    map linear address to FrameTracker which has been allocated.
    k 前缀版本用于内核（因为内核不是进程用不了prinx）
*/
void kmap(pte* pagedir, void *la, FrameTracker *ft)
{
    // assert(((u32)la & 0xFFF) == 0);
    // assert(ft->in_use);
    la = (u32)la & 0xFFFFF000;

    ft->count++;

    pte *final_entry = kget_final_entry(pagedir, la);
    // 默认给这三个权限
    *final_entry = ft->phybase | PG_P | PG_RWW | PG_USU;
}


/*
    unmap the page table entry
*/
FrameTracker *unmap(pte* pagedir, void *la)
{
    la = (u32)la & 0xFFFFF000;

    pte *final_entry = get_final_entry(pagedir, la);

    assert(*final_entry & PG_P);
    FrameTracker *f = frame_find(*final_entry & 0xFFFFF000);
    *final_entry = 0;

    f->count--;

    return f;
}