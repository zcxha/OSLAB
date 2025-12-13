# sudo mount /dev/loop6 /mnt/loopmnt
nasm boot/hdboot.asm -I boot/include/ -o hdboot.bin
nasm boot/hdldr.asm -I boot/include/ -o hdldr.bin
# sudo cp hdldr.bin /mnt/loopmnt/
# sudo cp kernel.bin /mnt/loopmnt/
# sudo umount /mnt/loopmnt
# 以下两行仅用于boot测试，写入MBR
# dd if=hdboot.bin of=test.img seek=0 bs=1 count=446 conv=notrunc
# dd if=hdboot.bin of=test.img seek=510 skip=510 bs=1 count=2 conv=notrunc

# 写入DBR 硬编码了
dd if=hdboot.bin of=test.img seek=1048576 bs=1 count=446 conv=notrunc
dd if=hdboot.bin of=test.img seek=1049086 skip=510 bs=1 count=2 conv=notrunc

# 写grub的stage
dd if=stage1 of=test.img bs=1 count=446 conv=notrunc
dd if=stage2 of=test.img bs=512 seek=1 conv=notrunc