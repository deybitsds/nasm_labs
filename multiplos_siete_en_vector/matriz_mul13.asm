;Escriba un programa que indique la fila y 
;columna en la que se encuentra el primer
;elemento múltiplo de 13, en una matriz de
; MxN. M, N y los elementos de la matriz deben
;ser ingresados por el usuario en tiempo de ejecución.

;Nombre : matriz_mul13.asm
;Proposito : ENCONTRAR EL PRIMER ELEMENTO M° 13 EN UNA MATRIZ
;Autor : 
;FCreacion : 04/013/2023
;FModific. : ---
;Compilar :
; nasm -f elf matriz_mul13.asm -Wall
; ld -m elf_i386 -s -o matriz_mul13 matriz_mul13.o io.o
; ./matriz_mul13

%include "io.mac"
section .bss
    matriz resw 200 ; Reservar 200 palabras de 2 bytes
    m resw 1 ; Numero de filas
    n resw 1 ; numero de columnas
    i resw 1 ; Indice de filas
    j resw 1 ; Indice de columnas

;Arreglar xd :V
section .data
    titulo db "APP PARA ENCONTRAR EL 1° ELEM. MUL. DE 13",10,0
    separarador db "========================================",10,0 
    msgFilas db "Ingrese M: ",0,10
    msgColumnas db "Ingrese N: ", 0,10
    tituloA db "MATRIZ",10,0
    separador2 db "------",10,0
    separador3 db "--------------------------------",10,0
    msgMul13 db "El primer elemento multiplo de 13 se encuentra en la ", 0
    msgFila db "Fila ",0
    msgFila1 db "Elemento ",0
    msgColumna db " y Columna ",0
    msgNoExiste db "No existe un elemento mul. 13 en la matriz",10,0
    puntos db " : ",0,10
    msjCambiar db "Cambiar Matrices (S/n): ",0,10
    msjMul13 db "Encontrar el primer elem. multipli de 13 (S/n): ",0,10
    tab db "",9,0

section .text
    global _start
_start:
    nwln 
    PutStr titulo

leer_datos:
    PutStr separarador
    ; LEER M 
    PutStr msgFilas
    GetInt word [m]
    
    ; LEER N
    PutStr msgColumnas
    GetInt word [n]
    ; PEDIR ELEMENTO
    PutStr separarador
    ;Leer cada elemento de la matriz...
    mov eax, 0
    mov ebx, matriz ; Direccion base de la matriz
    mov word[i], 0
    mov word[j], 0


; LEER MATRIZ 
bucle_filas:
    mov word[j], 0
bucle_columnas:
    inc word[i]
    PutStr msgFila1
    PutStr msgFila
    PutInt word[i]
    dec word[i]

    inc word[j]
    PutStr msgColumna
    PutInt word[j]
    dec word[j]
    PutStr puntos

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

; WAZAAA
;Mostrar matriz
mostrar_matriz:
    PutStr tituloA
    PutStr separador2
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

;mostrar_menu
mostrar_menu:
    ;imprimir 2
    PutStr separarador
    ;preguntar 6 
    PutStr msjMul13
    GetCh AL
    cmp AL, "S"
    je mul13_matriz
        ;si es "SI"
            ;imprimir 2
            ;redireccionar a modulo mul13_elemento
    ;preguntar 13
mostrar_menu1:
    PutStr msjCambiar
    GetCh AL 
    cmp AL, "S"
    je leer_datos
    jmp finalizar

mul13_matriz:
    PutStr separador3
    mov esi, 0
    mov ebx, matriz
    mov ax, 0
    mov dx,0
    mov word[i], 0
    mov word[j], 0
bucle_filas2A:
    mov word[j], 0
bucle_columnas2A:
    mov ax, 0
    mov dx, 0
    ;eax es el indice de la matriz y cada elemento es de 2 bytes
    mov ax, word[ebx+2*esi]
    mov di,13
    div di
    cmp dx,0
    je si_existe
    inc esi
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas2A
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas2A
    nwln

;caso no exista:
no_existe:
    PutStr msgNoExiste
    jmp mostrar_menu1

si_existe:
    ; Mostrar info
    PutStr msgMul13
    inc word[i]
    PutStr msgFila
    PutInt word[i]
    dec word[i]

    inc word[j]
    PutStr msgColumna
    PutInt word[j]
    dec word[j]
    PutStr puntos
    PutInt word[ebx+2*esi]
    nwln
    PutStr separarador
    jmp mostrar_menu1

finalizar:
    nwln 
    mov eax,1
    int 80h