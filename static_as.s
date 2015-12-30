# static_as.s - An Example Userspace Static Executable in Mac OS X
# 64 bit using AT&T syntax
# assembled on Mac OS X Snow Leopard
# author: Jay Hudson
# date: Dec. 30, 2015
# To assemble: as static_as.s -o static_as.o
# To link: ld -static -macosx_version_min 10.6 static_as.o -o static_as
# You can also type make in the source directory

.section __DATA,__data
str: 
	.asciz "Hello, I'm special because I am static.\n"

.section __TEXT,__text
.globl start
start:
  movq $0x2000004, %rax  # 0x04 is write syscall num; 2.... is the mask for bsd calls      
  movq $0x01, %rdi  # 0x01 is stdout                
  movq str@GOTPCREL(%rip), %rsi # @GOTPCREL relative address of global object table
  movq $0x28, %rdx  # the length of the string is put into rdx register            
  syscall # make the call

  movq $0x0, %rbx # 0x01 is the exit syscall
  movq $0x2000001, %rax # like return 0 in C     
  syscall
  ret # return
  



