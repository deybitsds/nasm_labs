;Nombre : matrizBi.asm
;Proposito : muestra el manejo de matrices bidimensionales
;Autor : Edwin Carrasco
;FCreacion : 29/12/2021
;FModific. : ---
;Compilar :
; nasm -f elf matrizBi.asm -Wall
; ld -m elf_i386 -s -o matrizBi matrizBi.o io.o
; ./matrizBi

%include "io.mac"

section .bss
    matriz: resw 200 ; Reservar 200 palabras de 2 bytes
    m: resw 1 ; Numero de filas
    n: resw 1 ; numero de columnas
    i: resw 1 ; Indice de filas
    j: resw 1 ; Indice de columnas

section .data
    msgFilas: db "Ingrese el nro de filas de la matriz : ",0
    msgColumnas: db "Ingrese el nro de columnas de la matriz : ",0
    msgElementos: db "Ingrese los elementos de uno en uno (fila por fila) : ",10,0
    tab: db "",9,0 ;Tabulacion entre columnas

section .text
    global _start
_start:
    ;Leer nro de filas
    PutStr msgFilas
    GetInt word [m]
    ;Leer nro de columnas
    PutStr msgColumnas
    GetInt word [n]
    ;Pedir elementos de la matriz
    PutStr msgElementos
    ;Leer cada elemento de la matriz...
    mov eax, 0

    mov ebx, matriz ; Direccion base de la matriz
    mov word[i], 0
    mov word[j], 0
bucle_filas:
    mov word[j], 0
bucle_columnas:
    GetInt dx
    ;eax es el indice de la matriz y cada elemento es de 2 bytes (1 palabra)
    mov word[ebx + 2 * eax], dx
    inc eax ;Actualizar indice
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas
    ;Leer cada elemento de la matriz y almacenarlos por filas
    mov eax, 0
    mov ebx, matriz
    mov word[i], 0
    mov word[j], 0
    nwln
;Mostrar matriz
bucle_filas2:
    mov word[j], 0
bucle_columnas2:
    ;eax es el indice de la matriz y cada elemento es de 2 bytes
    PutInt word[ebx+2*eax]
    PutStr tab ;Imprime un espacio despues de cada elemento
    inc eax
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas2
    nwln
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas2
    nwln
    
;Salir del programa
exit:
    mov eax, 1
    mov ebx, 0
    int 80h