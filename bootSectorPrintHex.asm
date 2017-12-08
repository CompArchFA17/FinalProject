print_hex:
    pusha		; Push all general purpose registers onto the stack
    mov cx, 0		; Index

hex_loop:
    cmp cx, 4 		; Loop four times
    je end		; Break loop
    
    mov ax, dx		; Last char of 'dx'    
    and ax, 0x000f	; Get least signifigant
    add al, 0x30	; Convert 0-9 to ASCII  
    cmp al, 0x39	; Check if A-F
    jle pos		; Jump if 'al' =< 0x39
    add al, 7 		; Convert A-F to ASCII

pos:
    mov bx, HEX + 5	; Base address + length
    sub bx, cx		; Subtract index
    mov [bx], al 	; Move char to position [bx]
    ror dx, 4		; Rotate 4 bits to right
    add cx, 1		; Index + 1
    jmp hex_loop	; Loop

end:
    mov bx, HEX
    call print		; Print
    popa		; Pop all general purpose registers off the stack
    ret

HEX:
    db '0x0000',0	; Reserve memory
