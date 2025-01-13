org 0x7C00                          ; BIOS loads bootloader to memory address 0x7C00 (IBM PC standard)
use16                               ; Run in 16-bit real mode (default for BIOS)

mov si, hello                       ; Load string address into source index register
mov ah, 0x0E                        ; Select BIOS video function 0x0E : write character in TTY mode (prints & advances cursor)

print:                    
    lodsb                           ; Load byte at [SI] into AL and increment SI (lodsb = load string byte)
    int 0x10                        ; Trigger BIOS interrupt 0x10 (video services) to display the character
    cmp al, 0                       ; Compare AL with 0 (null terminator) to check for end of string
    jne print                       ; Process next character

jmp $                               ; Jump to current address ($) - creates infinite loop to halt execution

hello:                   
    db "Hello, World!", 0           ; Define string with null terminator (0) to mark end

; Bootloader must be exactly 512 bytes (510 for code + 2 for boot signature).
; The 'times' directive fills unused space with zeros.
; ($ - $$) calculates current code size: $ is current position, $$ is start position (0x7C00)
; db ("define byte") allocates an 8-bit value
times 510 - ($ - $$) db 0          

; dw ("define word") allocates a 16-bit value
; The last two bytes must be the boot signature 0xAA55 (stored as 0x55, 0xAA in memory due to little-endian)
; BIOS checks for this signature to verify this is a bootable disk
dw 0xAA55
