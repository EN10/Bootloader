org 0x7C00                          ; BIOS always loads bootloader to 0x7C00 - a fixed address chosen by IBM in 1981
use16                               ; Use 16-bit real mode instructions

mov si, hello                       ; Load string address into source index register
call print                          ; Call print function to display string

halt:                     
    jmp halt                        ; Infinite loop to prevent executing past our code

print:                    
    lodsb                           ; Load byte at [SI] into AL and increment SI (lodsb = load string byte)
    or al, al                       ; Check if AL is 0 (sets zero flag if true)
    jz .print_end                   ; If zero flag set, reached string end
    mov ah, byte 0Eh                ; Set AH to 0E (hex) for BIOS teletype output (prints char in AL and auto-advances cursor)
    int 10h                         ; Call BIOS video interrupt (10h = 0x10 in hexadecimal)
    jmp print                       ; Process next character
.print_end:              
    ret                             ; Return from subroutine

hello:                   
    db "Hello, boot world!", 0      ; db = Define Byte - stores each character as a byte
                                    ; String with null terminator (0) to mark end

pad:                     
    db 510 - ($ - $$) dup 0         ; Pad bootloader to 510 bytes with zeros
                                    ; $ = current address, $$ = start address (0x7C00)
                                    ; ($ - $$) calculates how many bytes we've written so far
                                    ; We need exactly 512 bytes total: 510 for code + 2 for boot signature

boot_sig:                
    db 55h, 0AAh                    ; Magic boot signature required by BIOS (must be last 2 bytes)
                                    ; Without this signature, BIOS won't recognize this as bootable
