dd if=/dev/zero of=disk.img bs=1G count=1
fdisk disk.img <<EOF
n





t
c

w

EOF
sudo losetup loop6 disk.img
sudo mkfs.vfat /dev/loop6p1

# sudo -H gparted /dev/loop6

# 写BOOT,LDR,KERN
sudo mount -t vfat -o nodev,flush /dev/loop6p1 /mnt/loopmnt
sudo cp boot/hdboot.bin /mnt/loopmnt
sudo cp boot/hdldr.bin /mnt/loopmnt
sudo cp kernel.bin /mnt/loopmnt
# write menu
sudo mkdir -p /mnt/loopmnt/boot/grub/
sudo cp boot/menu.lst /mnt/loopmnt/boot/grub/
sudo umount /mnt/loopmnt
sudo losetup -d /dev/loop6

# 根目录 0x302800

# 写入DBR 硬编码write
# dd if=boot/hdboot.bin of=disk.img bs=1 seek=1048576 count=446 conv=notrunc
# dd if=boot/hdboot.bin of=disk.img bs=1 seek=1049086 skip=510  count=2 conv=notrunc

# 写grub的stage
dd if=stage1 of=disk.img bs=1 count=446 conv=notrunc
dd if=stage1 of=disk.img bs=1 seek=510 skip=510 count=2 conv=notrunc
dd if=stage2 of=disk.img bs=512 seek=1 conv=notrunc