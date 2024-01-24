;Escriba un programa que determine si un entero E, ingresado por el usuario, se encuentra
;en un vector de N enteros. N, E y los elementos del vector son ingresados por el usuario en
;tiempo de ejecución.

;Nombre : buscarVector.asm
;Proposito : buscar un elemento en un vector
;Autores : David Fernando Prieto Cardoso y Luigiu Fernando. Valeriano Huacarpuma
;FCreacion : 16/06/2023
;FModific. : ---
;Compilar : nasm -f elf buscarVector.asm
; ld -m elf_i386 -s -o buscarVector buscarVector.o io.o
; ./buscarVector

%include "io.mac"
;section bss
section .bss
    nroElementos resd 1
    vector resd 1000

;section data
section .data
    titulo db "APP PARA BUSCAR UN ENTERO EN UN VECTOR",10,0
    separarador db "======================================",10,0
    pedirN db "Ingrese cantidad de elementos del vector: ",0,10
    pedirElem db "Ingrese elemento ",0
    pedirElem2 db " : ",0,10
    msjCambiar db "Cambiar Vector (S/n): ",0,10
    msjBuscar db "Buscar entero (S/n): ",0,10
    imprimirTab db "",9,0
    inputBuscar db "Ingrese entero a buscar: ",0,10
    output db "El entero ", 0
    outputsi db " SI se encuentra en el vector",10,0
    outputno db " NO se encuentra en el vector",10,0

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

;pedir elementos de 0 hasta N - 1
leer_siguiente:
    PutStr pedirElem
    inc esi ;aumentamos en 1 a esi
    PutLInt esi ;imprimimos ESI + 1
    dec esi ;decrementamos a esi en 1 para no alterar el programa
    PutStr pedirElem2 ;imprimimos " : "
    GetLInt eax 
    mov [vector + esi*4],eax ;Establecemos el valor leido, al indice de este en el vector
    inc esi ;incrementamos esi (el indice de los elementos)
    loopnz leer_siguiente ;si ecx != 0: regresamos a leer_siguiente, && c -= 1
 
;mostrar_menu
mostrar_menu:
    ;imprimir separador
    PutStr separarador
    ;preguntar si se desea un elemento en el vector
    PutStr msjBuscar
    GetCh AL
    cmp AL, "S" ; verificamos si la respuesta es SI
    je buscar_elemento ; caso sea SI, redireccionamos a buscar_elemento
    ;preguntar si se desea cambiar de vector
    PutStr msjCambiar
    GetCh AL 
    cmp AL, "S" ; verificamos si la respuesta es SI
    je leer_datos ; caso sea SI, redirrecionamos a leer_datos
    jmp finalizar ; caso no sea ninguno de los casos, redirrecionamos a finalizar

;buscar_elemento
buscar_elemento:
    ;imprimir separador
    PutStr separarador
    ;preguntar que elemento se desea buscar
    PutStr inputBuscar
    GetLInt eax ; leer elemento
    ;establecemos los valores de los registros
    xor esi,esi
    mov ecx, [nroElementos]

;recorrer_vector
recorrer_vector:    
    cmp [vector +esi*4],eax ;comparamos el elemento en turno con el elemento que se desea
    jz si_esta ; caso sean iguales redireccionamos a si_esta
    inc esi ; incrementamos esi + 1
    loopnz recorrer_vector ; si ecx !=0: regresamos a recorrer_vector, && c-=1

;no_esta
no_esta:
    ; caso ya se haya recorrido todo el vector y no se encuentre
    PutStr output ;imprimir que no se encuentra
    PutLInt eax ;imprimimos el elemento
    PutStr outputno
    ; regresamos y mostramos el menu (mostrar_menu)
    jmp mostrar_menu
    
;si_esta
si_esta:
    ;imprimimos que el elemento que se busca si se encontro
    PutStr output
    PutLInt eax
    PutStr outputsi
    ; regresamos y mostramos el menu (mostrar_menu)
    jmp mostrar_menu
    
;finalizar
finalizar:
    nwln
    mov eax,1
    int 80h