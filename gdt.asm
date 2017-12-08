gdt_init:
    dd 0x0		; 4 byte
    dd 0x0 		; 4 byte

gdt_info: 
    dw 0xffff		; Segment length
    dw 0x0      	; Segment base
    db 0x0       	; Segment base
    db 10011010b 	; Flags
    db 11001111b 	; Flags & segment length
    db 0x0       	; Segment base

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_desc:
    dw gdt_end - gdt_init - 1
    dd gdt_init

CODE_SEGMENT equ gdt_info - gdt_init
DATA_SEGMENT equ gdt_data - gdt_init
