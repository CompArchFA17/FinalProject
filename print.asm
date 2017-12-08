[bits 32]			; 32-bit protected mode

VIDEO_MEMORY equ 0xb8000	; Video memory address
COLOR equ 0x0f			; Text color

print_pmode:
    pusha			; Push all general purpose registers onto the stack
    mov edx, VIDEO_MEMORY	; Set initial address

print_pmode_loop:
    mov al, [ebx] 		; Move color address
    mov ah, COLOR

    cmp al, 0 			; End of string
    je print_pmode_end		; Jump

    mov [edx], ax 		; Store char and color
    add ebx, 1			; Next char
    add edx, 2			; Next video memory address position
    jmp print_pmode_loop	; Jump

print_pmode_end:
    popa			; Pop all general purpose registers off the stack
    ret
