nasm boot/hdboot.asm -I boot/include/ -o hdboot.bin
dd if=hdboot.bin of=test.img seek=0 bs=1 count=446 conv=notrunc
