;Compilar : nasm -f elf mayor_en_vector.asm
; ld -m elf_i386 -s -o mayor_en_vector mayor_en_vector.o /home/sds/Desktop/nasm/libreria_io/io.o
; ./mayor_en_vector

%include "/home/sds/Desktop/nasm/libreria_io/io.mac"
;section bss
section .bss
    nroElementos resd 1
    vector resd 1000

;section data
section .data
    titulo db "APP PARA CALCULAR EL MAYOR ENTERO EN UN VECTOR",10,0
    separarador db "==============================================",10,0
    pedirN db "Ingrese cantidad de elementos del vector: ",0,10
    pedirElem db "Ingrese elemento ",0
    pedirElem2 db " : ",0,10
    msjCambiar db "Cambiar Vector (S/n): ",0,10
    msjMenor db "Mostrar el mayor entero (S/n): ",0,10
    imprimirTab db "",9,0
    output db "El mayor elemento es: ",0 ,10
    output2 db "Con posición: ",0,10

;section text
section .text
    global _start
_start:    
    nwln
    ;Indicar proposito del programa
    PutStr titulo
    
    
    ;Pedir N, cantidad de elementos del vector
    
    
;leer_datos
leer_datos:
    PutStr separarador  
    ;borrar 
    PutStr pedirN 
    GetInt [nroElementos]
    xor dx,dx
    xor esi,esi
    mov ecx, [nroElementos]

;pedir elementos de 1 hasta N+1
leer_siguiente:
    PutStr pedirElem
    inc esi
    PutLInt esi
    dec esi
    PutStr pedirElem2
    GetLInt eax
    mov [vector + esi*4],eax
    inc esi
    loopnz leer_siguiente
    ;guardar elementos
;mostrar_menu
mostrar_menu:
    ;imprimir 2
    PutStr separarador
    ;preguntar 6 
    PutStr msjMenor
    GetCh AL
    cmp AL, "S"
    je mayor_elemento
        ;si es "SI"
            ;imprimir 2
            ;redireccionar a modulo buscar_elemento
    ;preguntar 7
    PutStr msjCambiar
    GetCh AL 
    cmp AL, "S"
    je leer_datos
    jmp finalizar
        ;si es "SI"
            ;imprimir 2
            ;redireccionar a modulo leer_datos
    ;redireccionar a finalizar

;buscar_elemento
mayor_elemento:
    PutStr separarador
    mov eax,-10000000
    xor esi,esi
    mov ecx, [nroElementos]
waza:
    mov ebx, esi
    mov eax, [vector +esi*4]

recorrer_vector:    
    cmp eax,[vector +esi*4]
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
    jmp mostrar_menu
    ;recorrer arreglo y comparar con elemento
        ;si el elemento en turno coincide con el buscado
            ;redireccionar a modulo si_esta
    ;imprimir 10
    ;redireccionar a modulo mostrar_menu

;finalizar
finalizar:
    nwln
    mov eax,1
    int 80h