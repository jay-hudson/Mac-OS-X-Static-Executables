; static.asm - An Example Userspace Static Executable in Mac OS X
; author: Jay Hudson
; date: Dec. 24, 2015
; To assemble: nasm -f macho static.asm
; To link: ld -static -e entrypoint -o static

section .text

global entrypoint               ; Program's entry point

entrypoint:
    push dword strlength        ; message length                           
    push dword staticmsg        ; message to write
    push dword 0x01             ; 0x01 refers to stdout

    ; create the syscall
    mov eax, 0x04               ; 0x04 is the write syscall 
    sub esp, 0x04               ; OS X need a bit of padding on the stack
    int 0x80                    ; This actually executed the syscall

    add esp, 0x10               ; Pushed three values, plus the pad to stack

    ; exit the program
    push dword 0x0              ; Equivalent to return 0 in C
    mov eax, 0x01               ; 0x01 is the syscall number for exit 
    sub esp, 0x04               ; OS X (and BSD) system calls needs "extra space" on stack
    int 0x80                    ; make the syscall

section .data

  staticmsg db "Hello, I'm special because I am static.", 0x0a  ; string plus newline
  strlength equ $-staticmsg             ; string length in bytes