[org 0x7c00]

KERNEL_OFFSET equ 0x1000 

    mov [BOOT_DRIVE], dl	; BIOS sets boot drive
    mov bp, 0x9000
    mov sp, bp

    mov bx, REAL_MODE 
    call print
    call print_nl		; Print

    call load_kernel		; Read kernel from disk
    call switch_pmode 		; Begin protected mode
    jmp $ 			; Never run but holds

%include "bootSectorPrint.asm"
%include "bootSectorPrintHex.asm"
%include "bootSectorDisk.asm"
%include "gdt.asm"
%include "print.asm"
%include "enter32.asm"

[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET	; Read from disk
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PMODE:
    call KERNEL_OFFSET		; Give kernel control
    jmp $ 			; Gain control from Kernel

BOOT_DRIVE db 0
REAL_MODE db "Real Mode", 0
PROTECTED_MODE db "Protected Mode", 0
LOAD_KERNEL db "Loading Kernel into Memory", 0

times 510 - ($-$$) db 0		; Padding
dw 0xaa55
