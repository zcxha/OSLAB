## 在硬盘上启动

将grub的stage1写入MBR，stage2写入MBR+1的块，然后将hdboot.bin,hdloader.bin,kernel.bin都以文件挂载的形式复制到对应分区。然后重启系统就可以使用了。

在这里，我重写了hdboot.bin，让它能够在FAT32文件系统中寻找到hdldr.bin从而加载并执行。

注意每次写映像之前，先找到这个分区对应的根目录位置相对于整个硬盘起始位置的偏移，将其写入ROOT_BASE_ADDR中。

映像转换工具：starwind v2v converter

#### 参考

1. https://askubuntu.com/questions/667291/create-blank-disk-image-for-file-storage 

2. https://alpha.gnu.org/gnu/grub/ 

3. https://zhuanlan.zhihu.com/p/615492566

4. [GNU GRUB Manual 0.97](https://www.gnu.org/software/grub/manual/legacy/)