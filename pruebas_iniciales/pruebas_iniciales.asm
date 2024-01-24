;Compilar : nasm -f elf pruebaa.asm
; ld -m elf_i386 -s -o pruebaa pruebaa.o /Desktop/nasm/libio/io.o
; ./pruebaa

%include "io.mac"

section .data
	hola: db "Hola mundoxxxx!",10,0
section .text
	global _start
_start:
	PutStr hola
	nwln
