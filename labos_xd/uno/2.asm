;Compilar : nasm -f elf 2.asm
; ld -m elf_i386 -s -o 2 2.o io.o
; ./2

%include "io.mac"
section .bss
    a resw 1
    b resw 1
    c resw 1
    d resw 1
    e resw 1

section .data
    A db "Ingrese A: ",0,10
    B db "Ingrese B: ",0,10
    
    Resul db "Resultado -> ",0,10

section .text
    global _start
_start:

    PutStr A
    GetInt word[a]
    PutStr B
    GetInt word[b]
    xor dx,dx ; DX = 0

calcular:
    mov ax,word[a] ; AX = A
    mov bx,word[b] ; BX = B
    mul bx ; AX = AX * BX
    sub ax,10 ; AX = AX - 10
    mov cx,15 ; CX = 15
    div cx ; AX = AX/CX 
    ; DONDE SE GUARDA EN AX = COCIENTE Y DX = RESIDUO
    sub ax,2 ; AX = AX - 2
    add dx,8 ; DX = DX + 8
    add ax,dx ; AX = AX + DX
    or ax, 0x00FE ; AX = OR (AX, 0x00FE)
    PutStr Resul
    PutInt ax ; IMPRIMIR RESULTADO
    nwln   
    mov eax,1
    int 80h