;Nombre : sumaPrimos3.asm
;Proposito : Calcula la suma de primos en un vector de 20 elementos
;Autores :  - Valeriano Huacarpuma Luigui Fernando - 211362
;           - Prieto Cardoso David Fernando - 210179
;FCreacion : 05/08/2023
;FModific. : ---
;Compilar : nasm -f elf sumaPrimos3.asm
; Enlazar : ld -m elf_i386 -s -o sumaPrimos3 sumaPrimos3.o io.o
; Ejecutar : ./sumaPrimos3


%include "io.mac"
;section bss
section .bss
    sumaPrimos resw 1
    vector resd 1000

;section data
section .data
    titulo db "APP HALLAR LA SUMA DE PRIMOS EN UN VECTOR DE 20 ELEMENTOS",10,0
    separarador db "=========================================================",10,0
    pedirN db "Ingrese cantidad de elementos del vector: ",0,10
    pedirElem db "Ingrese elemento ",0
    pedirElem2 db " : ",0,10
    output db "La suma de primos es: ",0 ,10
    separador2 db "=========================",10,0

;section text
section .text
    global _start

_start:    
    nwln
    ;Indicar proposito del programa
    PutStr titulo  
    
;leer_datos
leer_datos:
    PutStr separarador  
    ;Pedir N (cantidad de elementos del vector)

    ;Establecemos los valores de los registros
    xor esi,esi
    xor eax,eax
    xor ebx,ebx
    xor edx,edx
    mov ecx, 5 ; MOVEMOS EL NRO DE ELEMENTOS = 20 AL REGISTRO CONTADOR ECX

;pedir elementos de 0 hasta N-1
leer_siguiente:
    ;Pedimos al usuario que ingrese el elemento
    xor eax,eax
    PutStr pedirElem
    inc esi ;incrementamos esi (indice) en 1
    PutLInt esi ;imprimimos el indice aumentado
    dec esi ;decrementamos esi en 1
    PutStr pedirElem2 
    GetLInt eax  ;leemos el elemento
    push eax
    call esPrimo
    inc esi ;incrementamos el indice en 1
    loopnz leer_siguiente

;finalizar
finalizar:
    PutStr separador2
    PutStr output
    PutLInt [sumaPrimos]
    nwln
    nwln
    mov eax,1
    int 80h

esPrimo:
    enter 0,0
    cmp eax, 1        ; Verificar si el número es 1
    je no_primo       ; Si es 1, no es primo, salta al final
    mov ebx, 2        ; Inicializar el divisor en 2
    push ebx
    esPrimo_loop:
        mov eax,[ebp + 8]
        cmp ebx, eax  ; Comparar el divisor con el número
        jge es_primo  ; Si el divisor es mayor o igual al número, es primo
        xor edx, edx   ; Limpiar EDX para la operación de división
        div word[ebp + 10]   ; Dividir eax (número) por ecx (divisor)
        cmp edx, 0 ; Verificar si hay residuo
        je no_primo   ; Si no hay residuo, no es primo, salta al final
        inc word[ebp + 10]  ; Incrementar el divisor
        jmp esPrimo_loop
    es_primo:
        add [sumaPrimos], eax ; Sumar el número a la variable [sumaPrimos]
    no_primo:
        pop ebx
        pop eax
        leave
        ret 4
