org 0x7C00                          ; Origin point where BIOS loads the bootloader
use16                               ; Use 16-bit real mode instructions

mov si, hello                       ; Load string address into source index register
call print                          ; Call print function to display string

halt:                     
    jmp halt                        ; Infinite loop to prevent executing past our code

print:                    
    lodsb                           ; Load byte at [SI] into AL and increment SI
    or al, al                       ; Check if AL is 0 (sets zero flag if true)
    jz .print_end                   ; If zero flag set, reached string end
    mov ah, byte 0Eh                ; Set AH to 0E (BIOS teletype output)
    mov bx, word 03h                ; Set page (BH=0) and color (BL=3)
    int 10h                         ; Call BIOS video interrupt
    jmp print                       ; Process next character
.print_end:              
    ret                             ; Return from subroutine

hello:                   
    db "Hello, boot world!", 0      ; db = Define Byte - stores each character as a byte
                                    ; String with null terminator (0) to mark end

pad:                     
    db 510 - ($ - $$) dup 0         ; db = Define Byte - reserves space in memory
                                    ; Fill remaining space with zeros
                                    ; $ = current position, $$ = section start
                                    ; 510 bytes (not 512) because boot_sig is 2 bytes
                                    ; Total bootloader must be 512 bytes

boot_sig:                
    db 55h, 0AAh                    ; db = Define Byte - places these two specific bytes
                                    ; Required boot signature for BIOS (0x55, 0xAA)
