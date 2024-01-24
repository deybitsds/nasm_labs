;Escriba un programa que muestre el valor y la posición 
;del elemento menor de un vector
;de N enteros. Tanto N como los elementos 
;del vector son definidos por el usuario en tiempo
;de ejecución.
%include "io.mac"
section .data
    msg db "Ingrese una cadena: ",0
    len_msg equ $-msg
    buffer db 100
    len_buffer equ 100

section .text
    global _start

_start:
    ;Imprimir mensaje pidiendo la cadena
    PutStr msg

    ;Leer la cadena ingresada por el usuario
    GetStr buffer, len_buffer

    ;Calcular la longitud de la cadena
    mov eax, 0 ;contador
    mov ebx, buffer ; puntero al inicio de la cadena

loop:
    cmp byte [ebx], 0 ; verificar si se llego al final de la cadena
    je end_loop
    inc eax ; incrementar contador
    inc ebx ; avanzar al siguiente caracter
    jmp loop

end_loop:
    ;Imprimir la longitud de la cadena
    PutLInt eax
    
finalizar:
    ;Salir del programa
    nwln
    mov eax,1
    int 80h



