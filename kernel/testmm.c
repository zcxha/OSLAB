#include "type.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "proto.h"
#include "global.h"


void printint(u32 x)
{
	disp_int(x);
	disp_str(" ");
}

const int MAP_BITS = 1048576 / 32;

void test_mm()
{
	u32 bitmap[MAP_BITS];

	init_bitmap();

	get_bitmap(bitmap);

	for (register i = 0; i < 4; i++)
	{
		printint(bitmap[i]);
	}

	int va = 0x00401000;
	/* 测试地址转换方法 */
	int pa = VAToPA(va);

	disp_int(pa); // 输出一样的地址
	disp_str(" ");

	// int res = VAToPA(0xfffffffe);

	// disp_int(res); // 输出-1

	/* 测试unmap */
	pa = unmap(va);

	disp_int(pa);
	disp_str(" ");

	pa = VAToPA(va);

	disp_int(pa);
	disp_str(" ");

	/* 测试alloc */
	int blocks[3];
	int res = alloc_pages(3, &blocks[0]);

	get_bitmap(bitmap);
	for (register i = 0; i < 4; i++)
	{
		printint(bitmap[i]);
	}

	if (res == 0)
	{
		for (register i = 0; i < 3; i++)
		{
			disp_int(blocks[i]);
			disp_str(" ");
		}
	}

	/* 测试map */
	map(va, blocks[1]);

	pa = VAToPA(va);

	disp_int(pa);
	disp_str("\n");

	/* 释放以及测试free */
	unmap(va);

	pa = VAToPA(va);

	disp_int(pa);
	disp_str(" ");

	/* 测试free */
	free_pages(1, &blocks[1]);

	get_bitmap(bitmap);

	for (register i = 0; i < 4; i++)
	{
		printint(bitmap[i]);
	}

	alloc_pages(1, &blocks[1]);

    // bug: unmap之后应该要map回去

	disp_int(blocks[1]);
}