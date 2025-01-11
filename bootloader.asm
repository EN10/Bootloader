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
    mov ah, byte 0Eh                ; Set AH to 0E for BIOS teletype output (prints char in AL and auto-advances cursor)
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
    db 55h, 0AAh                    ; Required BIOS boot signature (0x55 = 0101 0101, 0xAA = 1010 1010) marks this as bootable
