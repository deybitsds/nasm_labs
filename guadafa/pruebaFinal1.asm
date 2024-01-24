;Compilar :
; nasm -f elf pruebaFinal1.asm -Wall
; ld -m elf_i386 -s -o pruebaFinal1 pruebaFinal1.o io.o
; ./pruebaFinal1


%include "io.mac"
section .bss
    matrizA resw 200 ; Reservar 200 palabras de 2 bytes
    matrizB resw 200
    m resw 1 ; Numero de filas
    n resw 1 ; numero de columnas
    i resw 1 ; Indice de filas
    j resw 1 ; Indice de columnas
    SumaCuadrados resw 1
    NroInicial resw 1
    contador resw 1
    waza resw 1

section .data
    titulo db "MOSTRAR NROS FELICES EN UNA MATRIZ MxN",10,0
    separarador db "===============================",10,0 
    separadador2 db "--------",10,0
    msgFilas db "Ingrese M : ",0,10
    msgColumnas db "Ingrese N : ", 0,10
    tituloA db "MATRIZ",10,0
    separadador3 db "-----", 10,0
    msgFila db "Elemento Fila ",0
    msgColumna db " y Columna ",0
    puntos db " : ",0,10
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
    GetInt ax
    jmp wazaaa
    PutStr msgFilas
    GetInt word [m]
    ; LEER N
    PutStr msgColumnas
    GetInt word [n]

; LEER MATRIZ 
leer_matriz:
    PutStr separarador
    ;IMPRIMIR INFO A
    PutStr tituloA
    PutStr separadador2
    ;Leer cada elemento de la matriz A ...
    mov esi, 0
    mov ebx, matrizA ; Direccion base de la matriz
    mov word[i], 0
    mov word[j], 0
bucle_filas:
    mov word[j], 0
bucle_columnas:
    ; Pedir FILA
    inc word[i]
    PutStr msgFila
    PutInt word[i]
    dec word[i]
    ; Pedir COLUMNA
    inc word[j]
    PutStr msgColumna
    PutInt word[j]
    dec word[j]
    ;Puntos
    PutStr puntos
    GetInt ax
    ;esi es el indice de la matriz y cada elemento es de 2 bytes (1 palabra)
    mov word[ebx + 2 * esi], ax
    inc esi ;Actualizar indice
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas
    ;Leer cada elemento de la matriz y almacenarlos por filas
    mov esi, 0
    mov ebx, matrizA
    xor eax,eax
    mov word[i], 0
    mov word[j], 0
    nwln


;Mostrar matriz 
mostrar:
    PutStr tituloA
    PutStr separadador2
bucle_filas2A:
    mov ebx, matrizA
    mov word[j], 0
bucle_columnas2A:
    ;eax es el indice de la matriz y cada elemento es de 2 bytes
    mov ax, word[ebx + 2 * esi]
wazaaa:
    mov di,0
    mov word[SumaCuadrados],di
    mov word[contador],di
    mov [NroInicial],ax
    call esFuncion
    jmp finalizar
    inc esi
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas2A ; COLUMNAS
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas2A  ; FILAS
    nwln
    mov esi, 0
    mov word[i], 0
    mov word[j], 0


finalizar:
    nwln 
    mov eax,1
    int 80h


    

    
bucle_feliz:
    inc word[contador]
    mov ax, [SumaCuadrados]
    mov di,0
    mov [SumaCuadrados],di
esFuncion:
bucle_3:
    mov di,0
    cmp dx,di
    je acabo
bucle_feliz1:
    xor dx,dx
    mov di,10
    div di 
    call sumarDXCuadrado
    mov di,0
    cmp ax,di
    jne bucle_3
    

acabo:
    mov di,20
    cmp di,word[contador]
    je no_cumple
    mov di,1
    cmp di,word[SumaCuadrados]
    jne bucle_feliz

cumple:
    PutInt word[NroInicial]
    PutStr tab ;Imprime un espacio despues de cada elemento

no_cumple:
    xor dx,dx
    PutInt word[contador]
    ret

sumarDXCuadrado:
    mov word[waza],ax
    mov di,0
    cmp dx,0
    je sii
    mov ax,dx
sii:
    mul ax
    add word[SumaCuadrados],ax
    mov ax,word[waza]
    ret

    
