#include "type.h"
#include "const.h"
#include "mm/aspace.h"
#include "mm/page_table.h"
#include "mm/frame_allocator.h"

const u32 PTECNT = 1024;

pgtable_t *pagedir = PAGE_DIR_BASE;

/*
    TODO: 只有基本存在检查，后续应该要有权限检查
*/

void *la2pa(void *la)
{
    // 对齐
    assert(((u32)la & 0xFFF) == 0);
    u32 pdidx = ((u32)la >> 22);
    u32 ptidx = (((u32)la) & 0b1111111111000000000000) >> 12;

    assert(((pte *)(u32)(pagedir + pdidx))->paddr & PG_P);

    pgtable_t pt = (pgtable_t)((u32)(pagedir + pdidx) & 0xFFFFF000);

    assert(((pte *)(pt + ptidx))->paddr & PG_P);
    return (((pte *)(pt + ptidx))->paddr & 0xFFFFF000);
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

    u32 pgidx = ((u32)la >> 22);
    pte* ptentry = (pte *)((u32)(pagedir + pgidx) & 0xFFFFF000);

    // 默认给这三个权限
    ptentry->paddr = ft->phybase | PG_P | PG_RWW | PG_USU;
}

/*
    unmap the page table entry
*/
void *unmap(void *la)
{
    assert(((u32)la & 0xFFF) == 0);

    u32 pgidx = ((u32)la >> 22);
    pte* ptentry = (pte *)((u32)(pagedir + pgidx) & 0xFFFFF000);

    FrameTracker *f = frame_find(ptentry);

    assert(ptentry->paddr & PG_P);
    ptentry->paddr = 0;

    f->count--;
}