org 0x7C00                ; BIOS loads bootloader to memory address 0x7C00 (IBM PC standard)
use16                     ; Run in 16-bit real mode (default for BIOS)

mov ah, 0Eh               ; Select BIOS video function 0Eh: write character in TTY mode (prints & advances cursor)
mov al, 'H'               ; Put ASCII character 'H' into AL register for printing
int 10h                   ; Trigger BIOS interrupt 10h (video services) to display the character

jmp $                     ; Jump to current address ($) - creates infinite loop to halt execution

; Bootloader must be exactly 512 bytes (510 for code + 2 for boot signature).
; The 'times' directive fills unused space with zeros.
; ($ - $$) calculates current code size: $ is current position, $$ is start position (0x7C00)
; db ("define byte") allocates an 8-bit value
times 510 - ($ - $$) db 0

; dw ("define word") allocates a 16-bit value
; The last two bytes must be the boot signature 0xAA55 (stored as 0x55, 0xAA in memory due to little-endian)
; Required by BIOS to recognize this as bootable
dw 0AA55h 