;Compilar :
; nasm -f elf feliz.asm -Wall
; ld -m elf_i386 -s -o feliz feliz.o io.o
; ./feliz
%include "io.mac"

section .data
    mensaje db "Ingrese un número entero: ", 0
    buffer db 16    ; Tamaño del buffer para almacenar la cadena (16 caracteres)
    entero dw 0     ; Variable para almacenar el número entero

section .text
    global _start

_start:
    ; Mostrar el mensaje para ingresar el número
    mov ax,2
    add bx,ax
    mov cx,8
    mov dx,78
    mul bx
    PutInt ax
    nwln
    PutInt bx
    nwln
    PutInt cx
    nwln
    PutInt dx 
    nwln   ; Finalizar el programa
    mov eax, 1
    int 80h
