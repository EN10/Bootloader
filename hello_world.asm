org 0x7C00                          ; BIOS loads bootloader to memory address 0x7C00 (IBM PC standard)
use16                               ; Run in 16-bit real mode (default for BIOS)

mov si, hello                       ; Load string address into source index register
call print                          ; Call print function to display string

jmp $                              ; Jump to current address ($) - creates infinite loop to halt execution

print:                    
    lodsb                          ; Load byte at [SI] into AL and increment SI (lodsb = load string byte)
    or al, al                      ; Check if AL is 0 (sets zero flag if true)
    jz .print_end                  ; If zero flag set, reached string end
    mov ah, 0Eh                    ; Select BIOS video function 0Eh: write character in TTY mode (prints & advances cursor)
    int 10h                        ; Trigger BIOS interrupt 10h (video services) to display the character
    jmp print                      ; Process next character
.print_end:              
    ret                            ; Return from subroutine

hello:                   
    db "Hello, World!", 0          ; Define string with null terminator (0) to mark end

; Bootloader must be exactly 512 bytes (510 for code + 2 for boot signature).
; The 'times' directive fills unused space with zeros.
; ($ - $$) calculates current code size: $ is current position, $$ is start position (0x7C00)
; db ("define byte") allocates an 8-bit value
times 510 - ($ - $$) db 0          

; dw ("define word") allocates a 16-bit value
; The last two bytes must be the boot signature 0xAA55 (stored as 0x55, 0xAA in memory due to little-endian)
; Required by BIOS to recognize this as bootable
dw 0AA55h 