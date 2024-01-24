;Nombre : sumaVector.asm
;Proposito : sumar los elementos de un vector
;Autor : Edwin Carrasco
;FCreacion : 04/08/2020
;FModific. : ---
;Compilar : nasm -f elf sumaVector.asm
; ld -m elf_i386 -s -o sumaVector sumaVector.o io.o
; ./sumaVector
%include "io.mac"
section .data
    proposito db "ESTE PROGRANA SUMA LOS ELEMENTOS DE UN VECTOR DE ENTEROS",10,0
    tamano db "Defina el tamaño del vector: ",0
    entrada db "A continuación ingrese los elementos del vector: ",10,0
    salida db "Los elementos del vector son: ",10,0
    imprimirTab db "",9,0
    invitacion db "Ingrese el elemento ", 0
    pedirDatos db " del vector: ", 0
    resultado db "La suma de los elemetnos del vector es: ", 0

section .bss
    nroElementos resd 1 ; tamaño de arreglo
    vector resd 1000

section .text  
    global _start

_start:
    ;Indicar propostio del programa 
    PutStr proposito

    ;Leer tamaño del vector
    PutStr tamano
    GetInt [nroElementos]

    ;Leer elementos del vector 
leer_datos:
    PutStr entrada
    xor esi,esi
    mov ecx, [nroElementos]

leer_siguiente:
    PutStr invitacion
    PutLInt esi
    PutStr pedirDatos
    GetLInt eax
    mov [vector + esi*4],eax
    inc esi ; incrementar indice de arreglo
    loopnz leer_siguiente 

    ;Procesar
    xor esi,esi
    xor eax, eax
    mov ecx, [nroElementos]

procesar_sgte:
    add eax, [vector + esi*4]
    inc esi
    loopnz procesar_sgte

    ;Mostrar vector
    mov ecx, [nroElementos]
    xor esi,esi
    PutStr salida

mostrar_siguiente:
    PutLInt [vector + esi * 4]
    PutStr imprimirTab
    inc esi
    loopnz mostrar_siguiente
    nwln

    ;Mostrar resultados
    PutStr resultado
    PutLInt eax
    nwln

    ;Volver al sistema 
    mov eax, 1
    int 80h


