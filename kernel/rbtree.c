/// 进程调度用的红黑树
/// 本红黑树基于算法导论进行实现
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

typedef unsigned int u32;

// rbnode *root = &tree->nil;

rbnode *tree_minimum(rbtree *tree, rbnode *x)
{
    while (x->left != &tree->nil)
    {
        x = x->left;
    }
    return x;
}

// rbnode *rb_next(rbnode *node)
// {
//     rbnode *parent;
//     if(node == &tree->nil)
//     {
//         return &tree->nil;
//     }

//     if(node->right)
//     {
//         node = node->right;
//         while (node->left)
//         {
//             node = node->left;
//         }
//         return node;
//     }

//     while ((parent = node->p) != &tree->nil && node == parent->right)
//     {
//         /* code */
//         node = parent;
//     }
//     return parent;

// }

void *__pick_first_entity(rbtree *tree)
{
    rbnode *minimum = tree_minimum(tree, tree->root);
    if (minimum == &tree->nil)
        return NULL;
    return minimum->entity;
}

void left_rotate(rbtree *tree, rbnode *x)
{
    rbnode *y = x->right;
    x->right = y->left;
    if (y->left != &tree->nil)
    {
        y->left->p = x;
    }
    y->p = x->p;
    if (x->p == &tree->nil)
    {
        tree->root = y;
    }
    else if (x == x->p->left)
    {
        x->p->left = y;
    }
    else
    {
        x->p->right = y;
    }
    y->left = x;
    x->p = y;
}

void right_rotate(rbtree *tree, rbnode *x)
{
    rbnode *y = x->left;
    x->left = y->right;
    if (y->right != &tree->nil)
    {
        y->right->p = x;
    }
    y->p = x->p;
    if (x->p == &tree->nil)
    {
        tree->root = y;
    }
    else if (x == x->p->left)
    {
        x->p->left = y;
    }
    else
    {
        x->p->right = y;
    }
    y->right = x;
    x->p = y;
}

void rb_insert_fixup(rbtree *tree, rbnode *z)
{
    while (z->p->color == RB_RED)
    {
        if (z->p == z->p->p->left)
        {
            rbnode *y = z->p->p->right;
            if (y->color == RB_RED)
            {
                z->p->color = RB_BLACK;
                y->color = RB_BLACK;
                z->p->p->color = RB_RED;
                z = z->p->p;
            }
            else
            {
                if (z == z->p->right)
                {
                    z = z->p;
                    left_rotate(tree, z);
                }
                z->p->color = RB_BLACK;
                z->p->p->color = RB_RED;
                right_rotate(tree, z->p->p);
            }
        }
        else
        {
            rbnode *y = z->p->p->left;
            if (y->color == RB_RED)
            {
                z->p->color = RB_BLACK;
                y->color = RB_BLACK;
                z->p->p->color = RB_RED;
                z = z->p->p;
            }
            else
            {
                if (z == z->p->left)
                {
                    z = z->p;
                    right_rotate(tree, z);
                }
                z->p->color = RB_BLACK;
                z->p->p->color = RB_RED;
                left_rotate(tree, z->p->p);
            }
        }
    }
    tree->root->color = RB_BLACK;
}

void rb_insert(rbtree *tree, rbnode *z)
{
    rbnode *y = &tree->nil;
    rbnode *x = tree->root;
    while (x != &tree->nil)
    {
        y = x;
        if (z->key < x->key)
        {
            x = x->left;
        }
        else
        {
            x = x->right;
        }
    }
    z->p = y;
    if (y == &tree->nil)
    {
        tree->root = z;
    }
    else if (z->key < y->key)
    {
        y->left = z;
    }
    else
    {
        y->right = z;
    }
    z->left = &tree->nil;
    z->right = &tree->nil;
    z->color = RB_RED;
    rb_insert_fixup(tree, z);
}

void rb_transplant(rbtree *tree, rbnode *u, rbnode *v)
{
    if (u->p == &tree->nil)
    {
        tree->root = v;
    }
    else if (u == u->p->left)
    {
        u->p->left = v;
    }
    else
    {
        u->p->right = v;
    }
    if (v != &tree->nil)
        v->p = u->p;
}

void rb_delete_fixup(rbtree *tree, rbnode *x)
{
    while (x != tree->root && x->color == RB_BLACK)
    {
        if (x == x->p->left)
        {
            rbnode *w = x->p->right;
            if (w->color == RB_RED)
            {
                w->color = RB_BLACK;
                x->p->color = RB_RED;
                left_rotate(tree, x->p);
                w = x->p->right;
            }
            if (w->left->color == RB_BLACK && w->right->color == RB_BLACK)
            {
                w->color = RB_RED;
                x = x->p;
            }
            else
            {
                if (w->right->color == RB_BLACK)
                {
                    w->left->color = RB_BLACK;
                    w->color = RB_RED;
                    right_rotate(tree, w);
                    w = x->p->right;
                }
                w->color = x->p->color;
                x->p->color = RB_BLACK;
                w->right->color = RB_BLACK;
                left_rotate(tree, x->p);
                x = tree->root;
            }
        }
        else
        {
            rbnode *w = x->p->left;
            if (w->color == RB_RED)
            {
                w->color = RB_BLACK;
                x->p->color = RB_RED;
                right_rotate(tree, x->p);
                w = x->p->left;
            }
            if (w->right->color == RB_BLACK && w->left->color == RB_BLACK)
            {
                w->color = RB_RED;
                x = x->p;
            }
            else
            {
                if (w->left->color == RB_BLACK)
                {
                    w->right->color = RB_BLACK;
                    w->color = RB_RED;
                    left_rotate(tree, w);
                    w = x->p->left;
                }
                w->color = x->p->color;
                x->p->color = RB_BLACK;
                w->left->color = RB_BLACK;
                right_rotate(tree, x->p);
                x = tree->root;
            }
        }
    }
    x->color = RB_BLACK;
}

void rb_delete(rbtree *tree, rbnode *z)
{
    rbnode *y = z;
    u32 y_original_color = y->color;
    rbnode *x;
    if (z->left == &tree->nil)
    {
        x = z->right;
        rb_transplant(tree, z, z->right);
    }
    else if (z->right == &tree->nil)
    {
        x = z->left;
        rb_transplant(tree, z, z->left);
    }
    else
    {
        y = tree_minimum(tree, z->right);
        y_original_color = y->color;
        x = y->right;
        if (y->p == z)
        {
            x->p = y;
        }
        else
        {
            rb_transplant(tree, y, y->right);
            y->right = z->right;
            y->right->p = y;
        }
        rb_transplant(tree, z, y);
        y->left = z->left;
        y->left->p = y;
        y->color = z->color;
    }
    if (y_original_color == RB_BLACK)
    {
        rb_delete_fixup(tree, x);
    }
}
// #include <stddef.h>
// #include <stdio.h>
// #include <stdlib.h>
// int main()
// {
//     rbtree tree;
//     tree.root = &tree.nil;
//     rbnode a = {0, 999, 0, NULL, NULL, NULL};
//     rbnode b = {0, 666, 0, NULL, NULL, NULL};
//     rbnode d = {0, 3, 0, NULL, NULL, NULL};
//     rb_insert(&tree, &a);
//     rb_insert(&tree, &b);
//     printf("a: %d %d %d %d %d %d\n", a.color, a.key, a.left, a.p, a.right, a.entity);
//     printf("b: %d %d %d %d %d %d\n", b.color, b.key, b.left, b.p, b.right, b.entity);

//     printf("mini: %d\n", tree_minimum(&tree, tree.root)->key);

//     while (1)
//     {
//         int op = 0;
//         scanf("%d", &op);
//         if (op == 0)
//         { // insert
//             int key = 0;
//             scanf("%d", &key);
//             rbnode *p = malloc(sizeof(rbnode));
//             p->color = 0;
//             p->key = key;
//             p->entity = p->left = p->p = p->right = NULL;
//             rb_insert(&tree, p);

//             printf("mini: %d\n", tree_minimum(&tree, tree.root)->key);
//         }
//         else
//         { // delete
//         }
//     }

//     // printf("nex: %d\n", rb_next(tree_minimum(tree.root))->key);
// }