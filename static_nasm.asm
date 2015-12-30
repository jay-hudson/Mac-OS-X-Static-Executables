; static_asm.asm - An Example Userspace Static Executable in Mac OS X
; 64 bit using Nasm syntax
; assembled on Mac OS X Snow Leopard
; author: Jay Hudson
; date: Dec. 30, 2015
; To assemble: nasm -f macho64 static_nasm.asm
; To link: ld -static -o -macosx_version_min 10.6 static_nasm static_nasm.o
; You can also type make in the source directory

section .text
global start

start:
    mov     rax, 0x2000004 ; 0x04 is write syscall num; 2.... is the mask for bsd calls
    mov     rdi, 0x01 ; 0x01 is stdout 
    mov     rsi, msg ; copy the message pointer to rsi
    mov     rdx, msg.len ; the length of the string is put into rdx register   
    syscall ;  make the call

    mov     rax, 0x2000001 ; 0x01 is the exit syscall
    mov     rdi, 0 ; like return 0 in C
    syscall

section .data

msg:    db      "Hello, I'm special because I am static.", 10
.len:   equ     $-msg