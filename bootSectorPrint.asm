print:
    pusha		; Push all general purpose registers onto the stack

start:
    mov al, [bx]	; Base address of the string
    cmp al, 0		; If '0' we are at end of string
    je done		; Break loop
    mov ah, 0x0e	; BIOS interrupt
    int 0x10		; Interrupt vector (Video Services)
    add bx, 1		; Add 1
    jmp start		; Loop

done:
    popa		; Pop all general purpose registers off the stack
    ret

print_nl:
    pusha
    mov ah, 0x0e
    mov al, 0x0a	; Newline
    int 0x10
    mov al, 0x0d	; Return
    int 0x10
    popa
    ret
