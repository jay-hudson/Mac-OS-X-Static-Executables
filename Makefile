LD_FLAGS=-static -macosx_version_min 10.6

all: static_nasm static_as

static_nasm: static_nasm.asm
	@nasm -f macho64 static_nasm.asm
	@ld ${LD_FLAGS} static_nasm.o -o static_nasm

static_as: static_as.s
	@as static_as.s -o static_as.o
	@ld ${LD_FLAGS} static_as.o -o static_as

clean:
	rm static_nasm.o static_as.o static_nasm static_as