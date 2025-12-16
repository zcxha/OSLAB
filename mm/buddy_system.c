// #define WINDOWS
#ifndef WINDOWS
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
#else
#include <stdio.h>
#include <assert.h>
#include <type.h>
#include <stdlib.h>

#define panic(s) printf(s)
#endif
#include "mm/buddy_system.h"
u32 log_2(u32 i)
{
    assert(i > 0);
    u32 ans = 0;
    while (i != 1)
    {
        i = i / 2;
        ans++;
    }
    return ans;
}

u32 pow_2(u32 i)
{
    u32 ans = 1;
    while (i)
    {
        ans = ans * 2;
        i--;
    }
    return ans;
}

void buddy_list_insert(ListHead *head, ListNode *node)
{
    head->count++;
    ListNode *headnode = head->avail;

    node->prev = NULL;
    node->next = NULL;

    if (!headnode)
    {
        head->avail = node;
        head->count = 1;
    }
    else
    {
        headnode->prev = node;
        node->next = headnode;

        head->avail = node;
    }
}

void *buddy_list_pop(ListHead *head)
{
    assert(head->avail != NULL);
    head->count--;
    assert(head->count >= 0);
    ListNode *res = head->avail;

    head->avail = head->avail->next;
    if (head->avail)
    {
        head->avail->prev = NULL;
    }
    res->prev = res->next = NULL;
    return res;
}

void buddy_list_del(ListHead *head, ListNode *node)
{
    assert(head->avail != NULL);
    assert(node != NULL);
    head->count--;
    assert(head->count >= 0);
    if (node->prev)
    {
        node->prev->next = node->next;
    }
    else
    {
        head->avail = node->next;
    }

    if (node->next)
    {
        node->next->prev = node->prev;
    }

    node->prev = node->next = NULL;
}

/* buddy allocator tree */
BTree buddy_tree;

void print_table()
{
    for (int i = 1; i < BUDDY_ORDER; i++)
    {
        printf("[%2d]head:%10d\tcount:%10d\t\t", i, buddy_tree.nodes[i].avail, buddy_tree.nodes[i].count);
        if(i % 4 == 0) printf("\n");
    }
    printf("\n");
    // ListNode *p = buddy_tree.nodes[1].head;
    // printf("[");
    // while (p)
    // {
    //     printf("%x,", p->addr);
    //     p = p->next;
    // }
    // printf("]\n");
}

/*
    把堆空间初始化到根节点
*/
void buddy_init()
{
#ifdef WINDOWS
    u32 size = 0x10000000;
    u32 node_addr = malloc(size);
#else
    u32 size = HEAP_SIZE;
    u32 node_addr = HEAP_BASE;
#endif
    ListNode *next = NULL, *head = NULL;
    u32 blksz = LEAF_SIZE * pow_2(log_2(BUDDY_ORDER - 1));
    while (size)
    {
        ListNode *cur = (ListNode *)node_addr;
        cur->id = 1;
        cur->addr = cur;
        cur->size = blksz;
        buddy_list_insert(&buddy_tree.nodes[1], cur);

        size -= blksz;
        node_addr += blksz;
    }

    buddy_tree.nodes[0].avail = NULL;
    buddy_tree.nodes[0].count = 0;
    for (int i = 2; i < BUDDY_ORDER; i++)
    {
        buddy_tree.nodes[i].avail = NULL;
        buddy_tree.nodes[i].count = 0;
    }
}

int lowbit(int x) { return x & (-x); }

#define MAXBLOCK LEAF_SIZE *pow_2(log_2(BUDDY_ORDER - 1))
#define maxdepth log_2(BUDDY_ORDER - 1)
#define blockszofdepth(x) LEAF_SIZE *pow_2(log_2(BUDDY_ORDER - 1) - (x))
#define depthofnode(id) log_2(id)
#define blockszofnode(id) blockszofdepth(depthofnode(id))
/*
    分配layout指定的块大小内存，返回基地址指针
    由外层进行偏移量的加减（就是加4，以保存id这个dealloc要用的信息）
*/
void *buddy_alloc(Layout mm_layout)
{
    u32 tsize = mm_layout.size;
    u32 size; // 最高位二进制位

    while (tsize)
    {
        size = tsize;
        tsize -= lowbit(tsize);
    }

    u32 alloc_size = (size == mm_layout.size ? mm_layout.size : (size << 1));
    assert(alloc_size <= MAXBLOCK);
    assert(alloc_size > 0);

    u32 cur_depth = maxdepth - log_2(alloc_size / LEAF_SIZE);

    u32 start_id = pow_2(cur_depth), end_id = pow_2(cur_depth + 1) - 1;

    assert(start_id >= 1 && end_id <= 31);

    for (u32 i = start_id; i <= end_id; i++)
    {
        if (buddy_tree.nodes[i].avail)
        {
            return buddy_list_pop(&buddy_tree.nodes[i]);
        }
    }
    for (int i = start_id - 1; i >= 1; i--)
    {
        if (buddy_tree.nodes[i].avail)
        {
            // 应该往下分裂几次
            int splitcnt = cur_depth - depthofnode(i);

            assert(splitcnt < maxdepth);

            int split_id = i;
            while (splitcnt--)
            {
                void *head = buddy_list_pop(&buddy_tree.nodes[split_id]);

                ListNode *left = head, *right = head + blockszofnode(split_id << 1);
                left->id = (split_id << 1), right->id = ((split_id << 1) ^ 1);
                left->addr = left, right->addr = right;
                left->size = blockszofnode(split_id << 1), right->size = blockszofnode((split_id << 1) ^ 1);
                buddy_list_insert(&buddy_tree.nodes[split_id << 1], head);
                buddy_list_insert(&buddy_tree.nodes[(split_id << 1) ^ 1], head + blockszofnode(split_id << 1));
                split_id = split_id << 1;
            }

            break;
        }
    }

    for (u32 i = start_id; i <= end_id; i++)
    {
        if (buddy_tree.nodes[i].avail)
        {
            return buddy_list_pop(&buddy_tree.nodes[i]);
        }
    }
#ifndef WINDOWS
    panic("no block %d", mm_layout.size);
#endif
    return NULL;
}
ListNode *p[4194304];

int lneq(ListNode *p1, ListNode *p2)
{
    return (p1->addr == p2->addr && p1->id == p2->id && p1->size == p2->size);
}

/*
    传入块基址，也就是说，由外层进行-4，然后再在这里进行分配。
*/
void buddy_dealloc(void *p)
{
    ListNode *ln = (ListNode *)p;

    while (buddy_tree.nodes[ln->id ^ 1].avail)
    {
        ListNode *t = buddy_tree.nodes[ln->id ^ 1].avail;
        ListHead *headnode = &buddy_tree.nodes[ln->id ^ 1];
        u32 id = ln->id;
        u32 flag = 0;
        while (t)
        {
            if (t->addr == ln->addr + ln->size)
            { // t的addr更大
                flag = 1;
                ln->size = ln->size << 1;
                ln->id = ln->id >> 1;
                buddy_list_del(headnode, t);
                break;
            }
            else if (t->addr + t->size == ln->addr)
            { // t的addr小
                flag = 1;
                ln = t->addr;
                ln->addr = t->addr;
                ln->size = ln->size << 1;
                ln->id = ln->id >> 1;

                buddy_list_del(headnode, t);
                break;
            }
            t = t->next;
            if (lneq(t, headnode->avail))
            {
                printf("链表指针重复");
            }
        }
        if (flag == 0)
        {
            // 没有合并块则break
            break;
        }
    }
    buddy_list_insert(&buddy_tree.nodes[ln->id], ln);
}

#ifdef WINDOWS
signed main()
{
    buddy_init();

    Layout mmlay;
    mmlay.size = 64;
    int cnt;
    cnt++;
//     printf("cnt: %d\n", cnt);
//     print_table();
//     p[0] = buddy_alloc(mmlay);
//     printf("block %d %d %d\n", p[0]->addr, p[0]->id, p[0]->size);
//     print_table();

//     mmlay.size = 128;
//     p[1] = buddy_alloc(mmlay);
//     printf("block %d %d %d\n", p[1]->addr, p[1]->id, p[1]->size);
// print_table();
//     mmlay.size = 256;
//     p[1] = buddy_alloc(mmlay);
//     printf("block %d %d %d\n", p[1]->addr, p[1]->id, p[1]->size);
// print_table();
//     mmlay.size = 512;
//     p[1] = buddy_alloc(mmlay);
//     printf("block %d %d %d\n", p[1]->addr, p[1]->id, p[1]->size);
//     print_table();

    while(1)
    {
        int op;
        printf("operation(1. alloc 2. dealloc): ");
        scanf("%d", &op);

        if(op == 1)
        {
            printf("size: ");
            scanf("%d", &mmlay.size);
            p[1] = buddy_alloc(mmlay);
            printf("block %d %d %d\n", p[1]->addr, p[1]->id, p[1]->size);
        }
        else 
        {
            printf("addr: ");
            scanf("%d", &p[0]);
            printf("deallocating...%d\n", p[0]);
            buddy_dealloc(p[0]);
        }
        print_table();
    }
}
#endif