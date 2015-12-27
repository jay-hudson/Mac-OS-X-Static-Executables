# static.asm - An Example Userspace Static Executable in Mac OS X
# author: Jay Hudson
# date: Dec. 24, 2015
# To assemble: nasm -f macho static.asm
# To link: ld -static -e entrypoint -o static


.data

    HelloWorldString:
    .ascii "Hello World\n"

.text

.globl _start

_start:
    # load all the arguments for write()
    movl $4, %eax
    movl $1, %ebx
    movl $HelloWorldString, %ecx
    movl $12, %edx
    # raises software interrupt to call write()
    int $0x80

    # call exit()
    movl $1, %eax
    movl $0, %ebx
    int $0x80

#     .globl _staticmsg
#     .data
#     .align 2
# _staticmsg:
#     .long   40 # string plus newline
  
#   strlength:
#    $40           # string length in bytes

# .text
# .globl _entrypoint               # Program's entry point
# _entrypoint:
#     push ebp
#     push esp, ebp
#     push $strlength        # message length                           
#     push $staticmsg        # message to write
#     push $0x01             # 0x01 refers to stdout

#     # create the syscall
#     mov $0x04, eax               # 0x04 is the write syscall 
#     sub $0x04, esp               # OS X need a bit of padding on the stack
#     int 0x80                    # This actually executed the syscall

#     add $0x10, esp               # Pushed three values, plus the pad to stack

#     # exit the program
#     push 0x0              # Equivalent to return 0 in C
#     mov $0x01, eax               # 0x01 is the syscall number for exit 
#     sub $0x04, esp               # OS X (and BSD) system calls needs "extra space" on stack
#     int 0x80                    # make the syscall

#   s