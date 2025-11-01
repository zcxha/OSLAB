#########################
# Makefile for LSL from Orange's#
#########################

# Entry Point
ENTRYPOINT = 0x30400

# Programs, flags, etc.
ASM		= nasm
PYTHON  = python3.7
ASMBFLAGS	= -I boot/include/
ASMKFLAGS	= -f elf
LD		= ld
LDFLAGS = -s -Ttext=$(ENTRYPOINT)

# Objects
OBJS = kernel.o rustprog.o kliba.o string.o
LSLKERNEL = kernel.bin
LSLBOOT = boot/boot.bin boot/loader.bin

# All Phony Targets
.PHONY : buildimg everything all final image clean realclean

everything: $(LSLBOOT) $(LSLKERNEL)

all : realclean everything

final : all clean

image : final buildimg

clean :
	rm -f $(OBJS)

realclean :
	rm -f $(OBJS) $(LSLBOOT) $(LSLKERNEL)

# We assume that "a.img" exists in current folder
buildimg :
	dd if=boot/boot.bin of=a.img bs=512 count=1 conv=notrunc
	sudo mount -o loop a.img /mnt/floppy/
	sudo cp -fv boot/loader.bin /mnt/floppy/
	sudo cp -fv kernel.bin /mnt/floppy
	sudo umount /mnt/floppy

boot/boot.bin : boot/boot.asm boot/include/load.inc boot/include/fat12hdr.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

boot/loader.bin : boot/loader.asm boot/include/load.inc \
			boot/include/fat12hdr.inc boot/include/pm.inc
	$(ASM) $(ASMBFLAGS) -o $@ $<

kernel.o: kernel/kernel.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

rustprog.o:
	./build.sh 2>&1 | tee build.json
	$(PYTHON) build.py

kernel.bin: $(OBJS)
	$(LD) $(LDFLAGS) -o $(LSLKERNEL) $(OBJS)

kliba.o: lib/kliba.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<

string.o: lib/string.asm
	$(ASM) $(ASMKFLAGS) -o $@ $<