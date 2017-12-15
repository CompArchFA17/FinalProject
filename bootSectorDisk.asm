disk_load:
    pusha		; Push all general purpose registers onto the stack
    push dx 		; Save dx
    mov ah, 0x02 	; Read
    mov al, dh   	; Number of sectors to read
    mov cl, 0x02 	; Sector
    mov ch, 0x00	; Cylinder
    mov dh, 0x00	; Head
    int 0x13 		; Interrupt vector (Low Level Disk Services)
    jc disk_error 	; Jump
    pop dx		; Load dx from stack
    cmp al, dh    	; Compare with BIOS
    jne sector_error	; Jump
    popa		; Pop all general purpose registers off the stack
    ret

disk_error:
    mov bx, DISK_ERROR	; Get string to print
    call print		; Print error
    call print_nl	; Print new line
    mov dh, ah		; Error code and disk
    call print_hex	; Call function
    jmp disk_loop	; Jump

sector_error:
    mov bx, SECTOR_ERROR
    call print		; Print

disk_loop:
    jmp $

DISK_ERROR: db "ERROR: Could not read disk.", 0
SECTOR_ERROR: db "ERROR: Incorrect number of sectors.", 0
