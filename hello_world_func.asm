org 0x7C00
use16

mov si, hello
mov ah, 0x0E
call print
jmp $

print:
    lodsb
    cmp al, 0
    je .print_end
    int 0x10
    jmp print
.print_end:
    ret

hello: db "Hello, World!", 0

times 510 - ($ - $$) db 0
dw 0xAA55