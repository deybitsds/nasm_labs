; SEA UN VECTOR DE 2 ELEMENTOS, CADA UNO DE 1 BYTE
; ELIMINAR PRIMER ELEMENTO
; INICIO:
; |0|0|0|0|0|0|0|0|0|1|0|1|0|1|0|1| = 85 
; |0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|1| = 127
; |0|0|0|0|0|0|0|0|1|1|1|0|1|0|0|1| = 233
; |0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|1| = 9
; FIN
; |0|0|0|0|0|0|0|0|0|1|0|1|0|1|0|1| = 85
; |0|0|0|0|0|0|0|0|1|1|1|0|1|0|0|1| = 233
; |0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|1| = 9
;Compilar : nasm -f elf eliminar_elemento_2B.asm
; ld -m elf_i386 -s -o eliminar_elemento_2B eliminar_elemento_2B.o io.o
; ./eliminar_elemento_2B
%include "io.mac"
;section .bss
section .bss
    vector resw 4

section .text
    global _start

_start:
    mov ax, 65
    mov [vector + 0 * 2],ax
    mov ax, 127
    mov [vector + 1 * 2],ax
    mov ax, 233
    mov [vector + 2 * 2],ax
    mov ax, 9
    mov [vector + 3 * 2],ax

    xor ax,ax ; reiniciar el valor de ax
    mov esi, 2 ; indice + 1 del elemento que se borrara
    ; ( se borrara elemento vector[1])
    mov cx,3 ;contador random
    
waza:
    mov ax, [vector + esi * 2]
    dec esi
    mov [vector + esi * 2], ax
    add esi,2
    loopnz waza

    PutInt [vector + 0 * 2]
    nwln
    PutInt [vector + 1 * 2]
    nwln
    PutInt [vector + 2 * 2]
    nwln
    PutInt [vector + 3 * 2]

finalizar:
    nwln
    mov eax,1
    int 80h