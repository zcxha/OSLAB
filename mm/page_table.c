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

pgtable_t *pagedir = (pgtable_t)PAGE_DIR_BASE;

/*
    TODO: 只有基本存在检查，后续应该要有权限检查
*/

/*
    获得二级页表的最后一级页表的页表项
*/
pte *get_final_entry(void *la)
{
    u32 pdidx = ((u32)la >> 22);
    u32 ptidx = (((u32)la) & 0b1111111111000000000000) >> 12;
    assert(((pte *)(u32)(pagedir + pdidx))->paddr & PG_P);

    pgtable_t pt = (pgtable_t)(((pte *)(u32)(pagedir + pdidx))->paddr & 0xFFFFF000);
    return (pte *)(pt + ptidx);
}

void *la2pa(void *la)
{
    // 对齐
    assert(((u32)la & 0xFFF) == 0);
    pte *final_entry = get_final_entry(la);
    assert(final_entry->paddr & PG_P);
    return (final_entry->paddr & 0xFFFFF000);
}

/*
    the la here is Linear Address, not Logical Address.
    The source code on book is not so tidy...
*/

/*
    map linear address to FrameTracker which has been allocated.
*/
void map(void *la, FrameTracker *ft)
{
    assert(((u32)la & 0xFFF) == 0);
    assert(ft->in_use);

    ft->count++;

    pte *final_entry = get_final_entry(la);
    // 默认给这三个权限
    final_entry->paddr = ft->phybase | PG_P | PG_RWW | PG_USU;
}

/*
    unmap the page table entry
*/
FrameTracker *unmap(void *la)
{
    assert(((u32)la & 0xFFF) == 0);

    pte *final_entry = get_final_entry(la);

    assert(final_entry->paddr & PG_P);
    FrameTracker *f = frame_find(final_entry->paddr & 0xFFFFF000);
    final_entry->paddr = 0;

    f->count--;

    return f;
}