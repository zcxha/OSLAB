#define WINDOWS

#ifndef WINDOWS
#include "const.h"
#include "type.h"
#include "proto.h"
#include "mm/aspace.h"
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
    ListNode *headnode = head->head;

    node->prev = NULL;
    node->next = NULL;

    if (!headnode)
    {
        head->head = node;
    }
    else
    {
        headnode->prev = node;
        node->next = headnode;

        head->head = node;
    }
}

void *buddy_list_pop(ListHead *head)
{
    assert(head->head != NULL);

    ListNode *res = head->head;

    head->head = head->head->next;
    if (head->head)
    {
        head->head->prev = NULL;
    }
    res->prev = res->next = NULL;
    return res;
}

void buddy_list_del(ListHead *head, ListNode *node)
{
    assert(head->head != NULL);
    assert(node != NULL);

    head->head = node->next;
    if (head->head)
    {
        head->head->prev = NULL;
    }
    ListNode *prev = node->prev;
    if (prev)
    {
        prev->next = node->next;
    }
    if (node->next)
    {
        node->next->prev = prev;
    }

    node->prev = node->next = NULL;
}

/* buddy allocator tree */
BTree buddy_tree;

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

    buddy_tree.nodes[0].head = NULL;
    for (int i = 2; i < BUDDY_ORDER; i++)
    {
        buddy_tree.nodes[i].head = NULL;
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
    for (u32 i = start_id; i <= end_id; i++)
    {
        if (buddy_tree.nodes[i].head)
        {
            return buddy_list_pop(&buddy_tree.nodes[i]);
        }
    }
    for (int i = start_id - 1; i >= 1; i--)
    {
        if (buddy_tree.nodes[i].head)
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
        if (buddy_tree.nodes[i].head)
        {
            return buddy_list_pop(&buddy_tree.nodes[i]);
        }
    }
    return NULL;
}
void *p[4194304];

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

    while (buddy_tree.nodes[ln->id ^ 1].head)
    {
        ListNode *t = buddy_tree.nodes[ln->id ^ 1].head;
        ListHead *headnode = &buddy_tree.nodes[ln->id ^ 1];
        u32 id = ln->id;
        u32 flag = 0;
        while (t)
        {
            if (t->addr == ln->addr + ln->size)
            {
                flag = 1;
                ln->size = ln->size << 1;
                ln->id = ln->id >> 1;
                buddy_list_del(headnode, t);
                break;
            }
            else if (t->addr + t->size == ln->addr)
            {
                flag = 1;
                ln->addr = t->addr;
                ln->size = ln->size << 1;
                ln->id = ln->id >> 1;

                buddy_list_del(headnode, t);

                break;
            }
            t = t->next;
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

void print_table()
{
    // for (int i = 1; i < BUDDY_ORDER; i++)
    // {
    //     printf("[%d]%10d\t", i, buddy_tree.nodes[i].head);
    // }
    // printf("\n");
    ListNode *p = buddy_tree.nodes[1].head;
    printf("[");
    while (p)
    {
        printf("%x,", p->addr);
        p = p->next;
    }
    printf("]\n");
}
signed main()
{
    buddy_init();

    Layout mmlay;
    mmlay.size = 64;
    // print_table();
    // int allocated = 0;
    // int cnt = 0;
    // for (int i = 0; i < 2; i++)
    // {
    //     void *p;
    //     if ((p = buddy_alloc(mmlay)) != NULL)
    //     {
    //         ListNode *ln = ((ListNode *)p);
    //         printf("addr %x size %d id %d\n", ln->addr, ln->size, ln->id);
    //         assert(ln->id >= 8 && ln->id < 16);
    //         cnt++;
    //         allocated += 64;
    //         print_table();
    //         buddy_dealloc(p);
    //     }
    // }
    // printf("cnt: %d\n", cnt);
    // printf("allocated: 0x%x\n", allocated);

    print_table();
    for (int i = 0; i < 128; i++)
    {
        p[i] = buddy_alloc(mmlay);
    }
    // print_table();
    for (int i = 0; i < 128; i++)
    {
        // print_table();
        buddy_dealloc(p[i]);
    }
    print_table();
}
#endif