;Compilar : nasm -f elf eliminar_elemento_4B.asm
; ld -m elf_i386 -s -o eliminar_elemento_4B eliminar_elemento_4B.o io.o
; ./eliminar_elemento_4B
; 0 1 2 3 4 5 6 7
; 0 1 2 4 5 6 7 

%include "io.mac"
;section .bss
section .bss
    vector resd 8 ; reservar 8 "conjuntos" de 4 bytes 


section .data
    mensaje db "ingrese elemento: "    
section .text
    global _start

_start:
    mov [vector + 0], 0
    mov ecx, 8
    xor esi,esi
aea:    
    ;PutStr mensaje
    mov eax, 1 
    mov [vector + esi * 4], eax
    inc esi
    loopnz aea
    PutLInt [vector + 7 * 4]
    nwln
    PutLInt [vector + 8 * 4]
    nwln
    PutLInt [vector + 9 * 4]
    nwln
    xor eax,eax ; reiniciar el valor de ax
    mov esi, 4 ; indice + 1 del elemento que se borrara
    ; ( se borrara elemento vector[1])
    mov ecx, 5;contador random ; creo que es esi + 1
    
waza:
    mov eax, [vector + esi * 4]
    dec esi
    mov [vector + esi * 4], eax
    add esi, 2
    ;loopnz waza
mov ecx, 9
mov esi, 0
imprimir:
    
    ;PutLInt [vector + esi * 4]
    nwln
    inc esi
    loopnz imprimir
    

finalizar:
    nwln
    mov eax,1
    int 80h