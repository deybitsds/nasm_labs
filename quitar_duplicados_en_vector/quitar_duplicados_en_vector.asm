;Eliminar duplicados: Escribe un programa 
;que tome un arreglo de números 
;como entrada y devuelva un nuevo arreglo
; sin elementos duplicados.

;Nombre : buscarVector.asm
;Proposito : buscar un elemento en un vector
;Autor : David Fernando Prieto Cardoso - 210179
;FCreacion : 22/06/2023
;FModific. : ---
;Compilar : nasm -f elf duplicados_en_vector.asm
; ld -m elf_i386 -s -o duplicados_en_vector duplicados_en_vector.o io.o
; ./duplicados_en_vector
%include "io.mac"
;section .bss
section .bss
    nroElementos resd 1 ; reservar 1 espacio de memoria de 4 Bytes
    vector resd 1000 ; resevar 1000 espacios de memoria de 4 Bytes
    vector1 resd 1000 ; nuevo vector 

;section .data
section .data

;section .text
section .text
    global _start

_start:
    ; imprimir titulo ,etcc

leer_datos: ;leer vector desde cero
    ;pedir nro elementos
    GetInt [nroElementos]
    xor vector,vector ;establecer elementos del vector en 0
    xor vector1, vector1 ;" " " " " "
    xor esi,esi
    mov ecx, [nroElementos]


leer_siguiente: ;leer elementos de 1 hasta N + 1
    ;pedir elemento ...
    inc esi
    ;mostar k (esi)
    dec esi
    ;imprimir " :"
    GetLInt eax
    mov [vector + esi*4], eax
    inc esi
    loopnz leer_siguiente

mostrar_menu: ;mostar menu 
    ;imprimir separador
    ;preguntar si usuario quiere quitar duplicados  
    GetCh AL
    cmp AL,"S"
    je duplicados
    ;preguntar si usuario quiere cambiar vector
    GetCh AL
    cmp AL, "S"
    je leer_datos
    jmp finalizar ;caso no quiera ningun caso, finalizar programa

duplicados:
    ;imprimir separador
    mov eax, 0
    xor esi,esi
    mov ecx, [nroElementos]

condicion:


recorrer_vector:
    mov eax, [vector + esi*4]
    ; 

    jmp mostrar_menu

finalizar:
    nwln
    mov eax, 1
    int 80h