#include "type.h"
#include "const.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "global.h"

typedef unsigned int u32;
rbnode nil = {BLACK, 0, &nil, &nil, &nil};

rbnode *root = &nil;

rbnode *tree_minimum(rbnode *x)
{
	while (x->left != &nil)
	{
		x = x->left;
	}
	return x;
}

sched_entity *__pick_first_entity()
{
	rbnode *minimum = tree_minimum(root);
	return minimum->se;
}

void left_rotate(rbnode *x)
{
	rbnode *y = x->right;
	x->right = y->left;
	if (y->left != &nil)
	{
		y->left->p = x;
	}
	y->p = x->p;
	if (x->p == &nil)
	{
		root = y;
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

void right_rotate(rbnode *x)
{
	rbnode *y = x->left;
	x->left = y->right;
	if (y->right != &nil)
	{
		y->right->p = x;
	}
	y->p = x->p;
	if (x->p == &nil)
	{
		root = y;
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

void rb_insert_fixup(rbnode *z)
{
	while (z->p->color == RED)
	{
		if (z->p == z->p->p->left)
		{
			rbnode *y = z->p->p->right;
			if (y->color == RED)
			{
				z->p->color = BLACK;
				y->color = BLACK;
				z->p->p->color = RED;
				z = z->p->p;
			}
			else
			{
				if (z == z->p->right)
				{
					z = z->p;
					left_rotate(z);
				}
				z->p->color = BLACK;
				z->p->p->color = RED;
				right_rotate(z->p->p);
			}
		}
		else
		{
			rbnode *y = z->p->p->left;
			if (y->color == RED)
			{
				z->p->color = BLACK;
				y->color = BLACK;
				z->p->p->color = RED;
				z = z->p->p;
			}
			else
			{
				if (z == z->p->left)
				{
					z = z->p;
					right_rotate(z);
				}
				z->p->color = BLACK;
				z->p->p->color = RED;
				left_rotate(z->p->p);
			}
		}
	}
	root->color = BLACK;
}

void rb_insert(rbnode *z)
{
	rbnode *y = &nil;
	rbnode *x = root;
	while (x != &nil)
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
	if (y == &nil)
	{
		root = z;
	}
	else if (z->key < y->key)
	{
		y->left = z;
	}
	else
	{
		y->right = z;
	}
	z->left = &nil;
	z->right = &nil;
	z->color = RED;
	rb_insert_fixup(z);
}

void rb_transplant(rbnode *u, rbnode *v)
{
	if (u->p == &nil)
	{
		root = v;
	}
	else if (u == u->p->left)
	{
		u->p->left = v;
	}
	else
	{
		u->p->right = v;
	}
	if (v != &nil)
		v->p = u->p;
}

void rb_delete_fixup(rbnode *x)
{
	while (x != root && x->color == BLACK)
	{
		if (x == x->p->left)
		{
			rbnode *w = x->p->right;
			if (w->color == RED)
			{
				w->color = BLACK;
				x->p->color = RED;
				left_rotate(x->p);
				w = x->p->right;
			}
			if (w->left->color == BLACK && w->right->color == BLACK)
			{
				w->color = RED;
				x = x->p;
			}
			else
			{
				if (w->right->color == BLACK)
				{
					w->left->color = BLACK;
					w->color = RED;
					right_rotate(w);
					w = x->p->right;
				}
				w->color = x->p->color;
				x->p->color = BLACK;
				w->right->color = BLACK;
				left_rotate(x->p);
				x = root;
			}
		}
		else
		{
			rbnode *w = x->p->left;
			if (w->color == RED)
			{
				w->color = BLACK;
				x->p->color = RED;
				right_rotate(x->p);
				w = x->p->left;
			}
			if (w->right->color == BLACK && w->left->color == BLACK)
			{
				w->color = RED;
				x = x->p;
			}
			else
			{
				if (w->left->color == BLACK)
				{
					w->right->color = BLACK;
					w->color = RED;
					left_rotate(w);
					w = x->p->left;
				}
				w->color = x->p->color;
				x->p->color = BLACK;
				w->left->color = BLACK;
				right_rotate(x->p);
				x = root;
			}
		}
	}
	x->color = BLACK;
}

void rb_delete(rbnode *z)
{
	rbnode *y = z;
	u32 y_original_color = y->color;
	rbnode *x;
	if (z->left == &nil)
	{
		x = z->right;
		rb_transplant(z, z->right);
	}
	else if (z->right == &nil)
	{
		x = z->left;
		rb_transplant(z, z->left);
	}
	else
	{
		y = tree_minimum(z->right);
		y_original_color = y->color;
		x = y->right;
		if (y->p == z)
		{
			x->p = y;
		}
		else
		{
			rb_transplant(y, y->right);
			y->right = z->right;
			y->right->p = y;
		}
		rb_transplant(z, y);
		y->left = z->left;
		y->left->p = y;
		y->color = z->color;
	}
	if (y_original_color == BLACK)
	{
		rb_delete_fixup(x);
	}
}
