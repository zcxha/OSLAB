# sudo mount /dev/loop6 /mnt/loopmnt
nasm boot/hdboot.asm -I boot/include/ -o hdboot.bin
nasm boot/hdldr.asm -I boot/include/ -o hdldr.bin
# sudo cp hdldr.bin /mnt/loopmnt/
# sudo cp kernel.bin /mnt/loopmnt/
# sudo umount /mnt/loopmnt
dd if=hdboot.bin of=test.img seek=0 bs=1 count=446 conv=notrunc
dd if=hdboot.bin of=test.img seek=510 skip=510 bs=1 count=2 conv=notrunc
