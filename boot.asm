bits 16
org 0x7c00

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov si, msg_hello
    call print_string

main_loop:
    mov ah, 0x00
    int 0x16

    cmp al, 0x0d
    je print_newline

    mov ah, 0x0e
    int 0x10

    jmp main_loop

print_newline:
    mov ah, 0x0e
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    jmp main_loop

print_string:
    pusha
.loop:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0e
    int 0x10
    jmp .loop
.done:
    popa
    ret

msg_hello: db "system v0.1 loaded", 0x0d, 0x0a, 0

times 510 - ($-$$) db 0
dw 0xaa55