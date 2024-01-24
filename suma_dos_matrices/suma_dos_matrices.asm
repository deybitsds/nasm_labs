;Escriba un programa que sume dos matrices 
;bidimensionales MxN y muestre tanto las
;matrices de entrada, como la matriz de 
;salida. M y N se definen en tiempo de ejecución, 
;al igual que los datos de las matrices.

;Nombre : suma_dos_matrices.asm
;Proposito : SUMA DOS MATRICES
;Autor : 
;FCreacion : 
;FModific. : ---
;Compilar :
; nasm -f elf suma_dos_matrices.asm -Wall
; ld -m elf_i386 -s -o suma_dos_matrices suma_dos_matrices.o io.o
; ./suma_dos_matrices

%include "io.mac"
section .bss
    matrizA resw 200 ; Reservar 200 palabras de 2 bytes
    matrizB resw 200
    m resw 1 ; Numero de filas
    n resw 1 ; numero de columnas
    i resw 1 ; Indice de filas
    j resw 1 ; Indice de columnas

section .data
    titulo db "APP PARA SUMAR DOS MATRICES MxN",10,0
    separarador db "===============================",10,0 
    separadador2 db "--------",10,0
    msgFilas db "Ingrese M : ",0,10
    msgColumnas db "Ingrese N : ", 0,10
    tituloA db "MATRIZ A",10,0
    tituloB db "MATRIZ B",10,0
    msgAB db "A + B",10,0
    separadador3 db "-----", 10,0
    msgFila db "Elemento Fila ",0
    msgColumna db " y Columna ",0
    puntos db " : ",0,10
    msjCambiar db "Cambiar Matrices (S/n): ",0,10
    msjSumar db "Sumar Matrices (S/n): ",0,10
    tab db "",9,0

section .text
    global _start
_start:
    nwln 
    PutStr titulo ;Imprimir titulo

leer_datos:

    ;LEER M Y N
    PutStr separarador
    ; LEER M 
    PutStr msgFilas
    GetInt word [m]
    ; LEER N
    PutStr msgColumnas
    GetInt word [n]

; LEER MATRIZ A 
leer_matriz:
    PutStr separarador
    ;IMPRIMIR INFO A
    PutStr tituloA
    PutStr separadador2
    ;Leer cada elemento de la matriz A ...
    mov eax, 0
    mov ebx, matrizA ; Direccion base de la matriz
    mov word[i], 0
    mov word[j], 0
bucle_filas:
    mov word[j], 0
bucle_columnas:
    ; Mostrar info
    inc word[i]
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
    mov ebx, matrizA
    mov word[i], 0
    mov word[j], 0
    nwln


;Mostrar matriz A
mostrar_a:
    PutStr tituloA
    PutStr separadador2
bucle_filas2A:
    mov ebx, matrizA
    mov word[j], 0
bucle_columnas2A:
    ;eax es el indice de la matriz y cada elemento es de 2 bytes
    PutInt word[ebx+2*eax]
    PutStr tab ;Imprime un espacio despues de cada elemento
    inc eax
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas2A
    nwln
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas2A
    nwln
    mov eax, 0
    mov word[i], 0
    mov word[j], 0

finalizar:
    nwln 
    mov eax,1
    int 80h