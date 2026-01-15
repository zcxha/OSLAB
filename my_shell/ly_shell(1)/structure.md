# ly_shell(1)

###### 目录结构

```bash
.
├── 80m.img
├── bochsrc
├── boot 引导加载程序目录
│   ├── boot.asm 引导扇区代码，负责加载Loader
│   ├── boot.bin
│   ├── include 引导加载相关头文件
│   │   ├── fat12hdr.inc FAT12文件系统头信息定义
│   │   ├── load.inc 加载器相关常量定义
│   │   └── pm.inc 保护模式相关常量与宏定义
│   ├── loader.asm 加载器代码，负责加载内核并跳转
│   └── loader.bin
├── command shell命令
│   ├── Makefile
│   ├── cat.c 查看文件内容命令
│   ├── echo.c 回显文本命令，与书上相同
│   ├── edit.c 简易文本编辑器
│   ├── inst.tar 系统安装包归档
│   ├── kernel.bin 内核二进制副本（用于打包）
│   ├── kill.c 终止进程命令
│   ├── ls.c 列出目录内容命令
│   ├── ps.c 查看系统进程信息命令
│   ├── pwd.c 显示当前工作目录命令
│   ├── remove.c 删除文件命令
│   ├── start.asm 应用程序启动引导代码
│   └── touch.c 创建空文件或更新时间戳
├── fs 文件系统服务进程
│   ├── disklog.c 磁盘日志记录功能
│   ├── link.c 文件链接与解除链接(unlink)实现
│   ├── main.c 文件系统主循环，处理IPC消息
│   ├── misc.c 文件系统辅助函数
│   ├── open.c 文件打开与关闭
│   └── read_write.c 文件读写
├── include 系统头文件目录
│   ├── ls.h ls命令所需的结构定义
│   ├── stdio.h 标准输入输出库头文件
│   ├── string.h 字符串操作库头文件
│   ├── sys 系统内核级头文件
│   │   ├── config.h 系统全局配置
│   │   ├── console.h 控制台结构定义
│   │   ├── const.h 系统常量定义
│   │   ├── fs.h 文件系统数据结构定义
│   │   ├── global.h 全局变量声明
│   │   ├── hd.h 硬盘驱动相关定义
│   │   ├── keyboard.h 键盘扫描码与缓冲区定义
│   │   ├── keymap.h 键盘映射表
│   │   ├── proc.h 进程控制块(PCB)与调度定义
│   │   ├── protect.h 保护模式描述符与选择子定义
│   │   ├── proto.h 全局函数原型声明
│   │   ├── sconst.inc 汇编使用的系统常量
│   │   └── tty.h TTY终端结构定义
│   └── type.h 基础数据类型定义
├── kernel 内核核心代码
│   ├── clock.c 时钟中断处理与调度触发
│   ├── console.c 控制台显示与屏幕操作
│   ├── global.c 全局变量实体定义
│   ├── hd.c 硬盘驱动程序，处理硬盘中断与请求
│   ├── i8259.c 8259A中断控制器初始化与异常处理
│   ├── kernel.asm 内核入口，中断处理程序(ISR)
│   ├── keyboard.c 键盘中断处理与输入解析
│   ├── klib.c 内核辅助库函数
│   ├── kliba.asm 汇编实现的内核辅助函数
│   ├── main.c 内核主函数，进程初始化与启动
│   ├── proc.c 进程调度(schedule)与系统调用分发
│   ├── protect.c GDT/IDT初始化与异常处理设置
│   ├── start.c 内核C语言入口，从汇编跳转至此
│   ├── systask.c 系统任务进程，处理系统级服务
│   └── tty.c TTY终端任务，处理输入输出交互
├── lib 用户空间C库与系统调用接口
│   ├── close.c close系统调用用户接口
│   ├── exec.c exec系统调用用户接口
│   ├── exit.c exit系统调用用户接口
│   ├── fork.c fork系统调用用户接口
│   ├── getpid.c getpid系统调用用户接口
│   ├── misc.c 库辅助函数
│   ├── open.c open系统调用用户接口
│   ├── orangescrt.a C运行时库静态归档
│   ├── printf.c 用户态printf实现
│   ├── read.c read系统调用用户接口
│   ├── stat.c stat系统调用用户接口
│   ├── string.asm 汇编优化的字符串操作
│   ├── syscall.asm 系统调用中断陷阱(INT 0x90)接口
│   ├── syslog.c 系统日志记录接口
│   ├── unlink.c unlink系统调用用户接口
│   ├── vsprintf.c 字符串格式化核心实现
│   ├── wait.c wait系统调用用户接口
│   └── write.c write系统调用用户接口
├── mm 内存管理服务进程
│   ├── exec.c exec系统调用内存分配逻辑
│   ├── forkexit.c fork与exit内存管理逻辑
│   └── main.c 内存管理主循环，处理IPC消息
├── Makefile 项目顶层构建脚本
├── command.md 命令功能详细说明文档
├── fix.md 问题修复记录文档
├── structure.md 本文档，项目目录结构说明
└── test.sh 自动化测试脚本
```
