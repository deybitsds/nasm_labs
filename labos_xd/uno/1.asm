;Compilar : nasm -f elf 1.asm
; ld -m elf_i386 -s -o 1 1.o io.o
; ./1

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
    C db "Ingrese C: ",0,10
    D db "Ingrese D: ",0,10
    E db "Ingrese E: ",0,10
    Resul db "Resultado -> ",0

section .text
    global _start
_start:

    PutStr A
    GetInt word[a]
    PutStr B
    GetInt word[b]
    PutStr C
    GetInt word[c]
    PutStr D
    GetInt word[d]
    PutStr E
    GetInt word[e]

calcular:
    mov ax,word[a] AX = A
    mov bx,word[b] BX = B 
    add bx,ax ; BX = B + A
    mov ax,word[c] AX = C
    mov cx,word[d] CX = D
    sub ax,cx ; AX = C - D 
    mov cx, ax ; CX = AX
    xor dx,dx ; DX = 0
    mov ax, bx ; AX = BX
    div cx ; AX = AX/CX
    add ax,word[e] ; AX = AX + E   
    PutStr Resul
    PutInt ax ; IMPRIMIR RESULTADO
    nwln ; SALTO DE LINEA
    mov eax,1
    int 80h