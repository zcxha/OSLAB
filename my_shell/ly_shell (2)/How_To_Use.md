### 如何使用

## Command
启动bochs，然后按shift + F2会进入第一个shell所在的tty，shift+F3是进入另一个shell所在的tty
在shell中输入命令即可

# ps
ps --help：输出ps的帮助信息
ps：输出当前运行的进程

# kill
kill --help：输出kill的帮助信息
kill：终止指定的进程

# ls
ls --help：输出ls的帮助信息
ls：输出当前目录下的文件和目录

# touch
touch --help：输出touch的帮助信息
touch 文件名1 文件名2...：创建多个空文件

# cat
cat --help：输出cat的帮助信息
cat 文件名：输出文件的内容

# remove
remove --help：输出remove的帮助信息
remove 文件名1 文件名2...：删除多个文件

# edit
edit --help：输出edit的帮助信息
edit 可执行文件名：执行shell命令
edit 文件名：创建一个空文件（不存在）或打开一个已存在的文件
edit 文件名 文件内容：向指定文件中覆盖写文件内容
edit 文件名 -a 文件内容：向指定文件中追加写文件内容