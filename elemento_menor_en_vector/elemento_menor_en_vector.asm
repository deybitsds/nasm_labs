;Escriba un programa que muestre el valor y la posición 
;del elemento menor de un vector
;de N enteros. Tanto N como los elementos 
;del vector son definidos por el usuario en tiempo
;de ejecución.

;Nombre : buscarVector.asm
;Proposito : buscar un elemento en un vector
;Autor : David Fernando Prieto Cardoso y Luigiu Fernando. Valeriano Huacarpuma
;FCreacion : 22/06/2023
;FModific. : ---
;Compilar : nasm -f elf menor_en_vector.asm
; ld -m elf_i386 -s -o menor_en_vector menor_en_vector.o io.o
; ./menor_en_vector

%include "io.mac"
;section bss
section .bss
    nroElementos resd 1
    vector resd 1000

;section data
section .data
    titulo db "APP PARA CALCULAR EL MENOR ENTERO EN UN VECTOR",10,0
    separarador db"==============================================",10,0
    pedirN db "Ingrese cantidad de elementos del vector: ",0,10
    pedirElem db "Ingrese elemento ",0
    pedirElem2 db " : ",0,10
    msjCambiar db "Cambiar Vector (S/n): ",0,10
    msjMenor db "Mostrar el menor entero (S/n): ",0,10
    imprimirTab db "",9,0
    output db "El menor elemento es: ",0 ,10
    output2 db "Con posición: ",0,10

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
    PutStr pedirN 
    GetInt [nroElementos]
    ;Establecemos los valores de los registros
    xor esi,esi
    mov ecx, [nroElementos]

;pedir elementos de 0 hasta N-1
leer_siguiente:
    ;Pedimos al usuario que ingrese el elemento
    PutStr pedirElem
    inc esi ;incrementamos esi (indice) en 1
    PutLInt esi ;imprimimos el indice aumentado
    dec esi ;decrementamos esi en 1
    PutStr pedirElem2 
    GetLInt eax  ;leemos el elemento
    mov [vector + esi * 4], eax ;guardamos el elemento leido en el vector 
    inc esi ;incrementamos el indice en 1
    loopnz leer_siguiente

;mostrar_menu
mostrar_menu:
    ;imprimimos el separador
    PutStr separarador
    ;preguntar si se desea buscar el menor elemento del vector
    PutStr msjMenor
    GetCh AL
    cmp AL, "S" ; verificamos si la respuesta es SI
    je menor_elemento ; caso sea SI, redireccionamos a menor_elemento

;mostar_menu1 (caso que no se desee preguntar si menor_elemento)
mostrar_menu1:    
    ;preguntamos si se desea cambiar de vector
    PutStr msjCambiar
    GetCh AL 
    cmp AL, "S" ;verificamos si la respuesta es SI
    je leer_datos ;caso sea SI, redireccionamos a leer_datos
    ;CASO NO SE DESEE HACER NINGUNO DE LOS DOS, FINALIZAMOS EL PROGRAMA
    jmp finalizar

;buscar_elemento
menor_elemento:
    PutStr separarador
    mov eax,100000
    xor esi,esi
    mov ecx, [nroElementos]
waza:
    mov ebx, esi
    mov eax, [vector +esi*4]

recorrer_vector:    
    cmp [vector +esi*4],eax
    js waza
    inc esi
    loopnz recorrer_vector
    PutStr output
    PutLInt eax
    nwln
    PutStr output2
    inc ebx
    PutLInt ebx
    nwln
    PutStr separarador
    jmp mostrar_menu1
    
;finalizar
finalizar:
    nwln
    mov eax,1
    int 80h