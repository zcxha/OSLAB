## sched
基于lab8，即实现CFS的版本进行集成


## FAT32启动的注意点：

1. 必须1 cluster = 8 sector， 经验之谈就是
```bash
dd if=/dev/zero of=test.img bs=1G count=1
# 挂载
sudo losetup loop6 test.img
# 在这里，用gparted建分区表、然后格式化为FAT32 随便弄个卷标，可以发现这个磁盘大小的时候
# 根目录的地址总是0x302800
sudo -H gparted /dev/loop6  # mkfs.vfat 1G的partition似乎也行
# 不信的话可以在里面先建个test.txt输入点内容然后执行以下命令找一下根目录在哪
xxd -a0 -g1 test.img
```

2. 建好盘之后，把kernel.bin和hdldr.bin都直接通过桌面Ubuntu复制过去

3. 然后执行testboot写grub的stage1到MBR，stage2到LBA1之后，在这里就可以直接用GRUB了，把boot写到DBR去。
```bash
# 写入DBR 硬编码了
dd if=hdboot.bin of=test.img seek=1048576 bs=1 count=446 conv=notrunc
dd if=hdboot.bin of=test.img seek=1049086 skip=510 bs=1 count=2 conv=notrunc

# 写grub的stage
dd if=stage1 of=test.img bs=1 count=446 conv=notrunc
dd if=stage2 of=test.img bs=512 seek=1 conv=notrunc
```

4. 因为直接装到第一个分区，所以grub的操作就是
```bash
rootnoverify (hd0, 0)
chainloader +1
boot
```

经过一天的迭代，这些全都过时了，详见mkimg.sh

### 已知问题:

经测试，在虚拟机VMWARE上可以运行lab7的kernel，但是当前的kernel暂时无法正常运行。

在真机上只测试了LAB，也是同样的经过loader之后无法运行kernel

映像转换工具：starwind v2v converter

#### 参考

1. https://askubuntu.com/questions/667291/create-blank-disk-image-for-file-storage 

2. https://alpha.gnu.org/gnu/grub/ 

3. https://zhuanlan.zhihu.com/p/615492566