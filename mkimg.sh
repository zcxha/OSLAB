dd if=/dev/zero of=disk.img bs=1G count=1
fdisk disk.img <<EOF
n





t
c

w

EOF
sudo losetup -d /dev/loop6 2>/dev/null || true
LOOP=$(sudo losetup --find --partscan --show disk.img)
sudo mkfs.vfat ${LOOP}p1

# sudo -H gparted /dev/loop6

# 写BOOT,LDR,KERN
sudo mount -t vfat ${LOOP}p1 /mnt/loopmnt
sudo cp boot/hdboot.bin /mnt/loopmnt
sudo cp boot/hdldr.bin /mnt/loopmnt
sudo cp kernel.bin /mnt/loopmnt
# write menu
sudo mkdir -p /mnt/loopmnt/boot/grub/
sudo cp boot/menu.lst /mnt/loopmnt/boot/grub/
sudo umount /mnt/loopmnt
sudo losetup -d $LOOP

# 根目录 0x302800

# 写入DBR 硬编码write
# dd if=boot/hdboot.bin of=disk.img bs=1 seek=1048576 count=446 conv=notrunc
# dd if=boot/hdboot.bin of=disk.img bs=1 seek=1049086 skip=510  count=2 conv=notrunc

# 写grub的stage
dd if=stage1 of=disk.img bs=1 count=446 conv=notrunc
dd if=stage1 of=disk.img bs=1 seek=510 skip=510 count=2 conv=notrunc
dd if=stage2 of=disk.img bs=512 seek=1 conv=notrunc

# 给vmware生成vmdk
# https://stackoverflow.com/questions/454899/how-to-convert-flat-raw-disk-image-to-vmdk-for-virtualbox-or-vmplayer
# qemu-img convert -O vmdk disk.img disk.vmdk
