all: run
kernel.bin: kernelEntry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernelEntry.o: kernelEntry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -c $< -o $@

bootSector.bin: bootSector.asm
	nasm $< -f bin -o $@

final.bin: bootSector.bin kernel.bin
	cat $^ > final.bin

run: final.bin
	qemu-system-i386 -fda $<

clean:
	rm -rf *.bin *.o

