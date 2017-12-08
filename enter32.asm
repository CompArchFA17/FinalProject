[bits 16]			; 16-bit Real Mode

switch_pmode:
    cli				; Disable interrupts
    lgdt [gdt_desc]		; Load GDT
    mov eax, cr0
    or eax, 0x1			; Set 32-bit mode bit high
    mov cr0, eax
    jmp CODE_SEGMENT:init_pmode

[bits 32]			; 32-bit Protected Mode

init_pmode:
    mov ax, DATA_SEGMENT	; Set data segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PMODE
