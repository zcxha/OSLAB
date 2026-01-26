# 项目总览
本分支由lsl独立完成，实现os基础功能、内存、调度、虚拟内存、硬盘启动等功能

ly分支在orange教材第十章系统的基础上实现了shell及相关指令，分支里还有对该版本系统漏洞的挖掘与修复

lzm分支在ly分支基础上实现了动静态的进程控制防护

mo分支在ly分支上实现了日志系统、文件保护和一个简单小游戏，并合并了lzm分支，最新一次commit为最完整系统


# OS KERNEL

###### 目录结构

```bash
.
├── 1.txt
├── bochsrc 这里配置了硬盘启动，以及内存为1024M
├── boot 系统加载器的相关代码
│   ├── boot.asm
│   ├── hdboot.asm
│   ├── hdldr.asm
│   ├── include
│   │   ├── fat12hdr.inc
│   │   ├── load.inc
│   │   └── pm.inc
│   ├── loader.asm
│   └── menu.lst
├── doc 文档
│   ├── arch.md 架构文档
│   ├── CFS schedule.docx
│   ├── CFS schedule.md CFS调度器文档
│   ├── fs.md 
│   ├── kernel arch.vsdx 系统架构设计图
│   ├── mm.md 内存管理设计文档
│   ├── mm.vsdx 内存管理设计图
│   ├── Q&A.md 
│   ├── sched.md 调度器设计文档
│   ├── sched.vsdx 调度器设计图
│   ├── Security.docx 
│   ├── Security.md 安全机制设计文档
│   ├── Security.vsdx 安全机制设计图
│   ├── trap & context switch.vsdx 上下文切换流程图
│   ├── 使用说明.md
│   └── 实验报告.docx 期末实验报告
├── drv 硬盘驱动
│   └── hd.c
├── floppyboot.sh 软盘启动脚本
├── fs
│   └── fat32.c
├── git-filter-repo
├── hdboot.sh 硬盘启动脚本
├── include
│   ├── console.h
│   ├── const.h
│   ├── drv
│   │   └── hd.h
│   ├── fs
│   │   └── fat32.h
│   ├── global.h
│   ├── keyboard.h
│   ├── keymap.h
│   ├── mm
│   │   ├── aspace.h
│   │   ├── buddy_system.h
│   │   ├── frame_allocator.h
│   │   ├── heap_allocator.h
│   │   ├── memory_set.h
│   │   └── page_table.h
│   ├── mm.h
│   ├── proc.h
│   ├── protect.h
│   ├── proto.h
│   ├── rbtree.h
│   ├── sconst.inc
│   ├── string.h
│   ├── test
│   │   └── testmm.h
│   ├── tty.h
│   └── type.h
├── kernel
│   ├── clock.c 包含时钟中断逻辑、完整性检查逻辑、CFS调度数据更新逻辑
│   ├── console.c
│   ├── global.c
│   ├── i8259.c
│   ├── kernel.asm
│   ├── keyboard.c
│   ├── main.c 包含用户进程的逻辑，以及添加这些进程的逻辑，是用户测例的实现地
│   ├── printf.c
│   ├── proc.c 包含进程添加逻辑、进程休眠与唤醒逻辑、调度逻辑
│   ├── protect.c
│   ├── rbtree.c 红黑树算法导论的实现
│   ├── start.c 
│   ├── syscall.asm
│   ├── systask.c
│   ├── tty.c
│   └── vsprintf.c
├── krnl.map
├── lib
│   ├── kliba.asm
│   ├── klib.c
│   ├── misc.c
│   └── string.asm
├── main.i
├── main.s main.c的中间产物，准确说是as之前。在这里你可以查看stack canary是否生成
├── Makefile
├── mkimg.sh 硬盘镜像构建脚本
├── mm 内存管理代码
│   ├── buddy_system.c 伙伴系统算法实现
│   ├── frame_allocator.c 物理页帧分配器
│   ├── heap_allocator.c 堆分配器
│   └── page_table.c 页表
├── rbtree.exe
├── README.md
├── snapshot.txt
├── stage1 grub的两个stage
├── stage2 grub的两个stage
├── temp
│   ├── mm.asm
│   └── testmm.c
├── temp.txt
└── test
    └── testmm.c

18 directories, 113 files

```

###### rust实现参考

见分支`lab6-rust`

###### 参考文献

可于`docs/`各文档中找寻。

[1] Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022).Introduction to algorithms. MIT press.

[2] https://www.hitzhangjie.pro/blog/%E4%BB%BB%E5%8A%A1%E8%B0%83%E5%BA%A67v2/

[3] https://puranikvinit.hashnode.dev/cfs-scheduler

[4] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c

[5] https://askubuntu.com/questions/667291/create-blank-disk-image-for-file-storage 

[6] https://alpha.gnu.org/gnu/grub/ 

[7] https://zhuanlan.zhihu.com/p/615492566

[8] [GNU GRUB Manual 0.97](https://www.gnu.org/software/grub/manual/legacy/)

[9] [c - 当你用指向内存分配中间位置的指针调用 free() 函数时会发生什么？ - Stack Overflow --- c - What happens when you call free() with a pointer to the middle of the allocation? - Stack Overflow](https://stackoverflow.com/questions/1957099/what-happens-when-you-call-free-with-a-pointer-to-the-middle-of-the-allocation)

[10] [rCore-Tutorial-Book-v3 3.6.0-alpha.1 文档](https://rcore-os.cn/rCore-Tutorial-Book-v3/)

[11] [Writing an OS in Rust](https://os.phil-opp.com/)

[12]《计算机程序设计艺术》第一卷

