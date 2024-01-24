

;Nombre : sumaPrimos2.asm
;Proposito : Calcula la suma de primos en un vector de 20 elementos
;Autores :  - Valeriano Huacarpuma Luigui Fernando - 211362
;           - Prieto Cardoso David Fernando - 210179
;FCreacion : 05/08/2023
;FModific. : ---
;Compilar : nasm -f elf sumaPrimosFINAL.asm
; Enlazar : ld -m elf_i386 -s -o sumaPrimosFINAL sumaPrimosFINAL.o io.o
; Ejecutar : ./sumaPrimosFINAL


%include "io.mac"
;section bss
section .bss
    sumaPrimos resw 1
    vector resd 1000
    original resw 1


;section data
section .data
    titulo db "APP HALLAR LA SUMA DE PRIMOS EN UN VECTOR DE 20 ELEMENTOS",10,0
    separarador db "=========================================================",10,0
    pedirN db "Ingrese cantidad de elementos del vector: ",0,10
    pedirElem db "Ingrese elemento ",0
    pedirElem2 db " : ",0,10
    output db "SUMA DE PRIMOS ES: ",0 ,10
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
    xor edi,edi
    mov ecx, 20 ; MOVEMOS EL NRO DE ELEMENTOS = 20 AL REGISTRO CONTADOR ECX
    mov ebx, vector
    mov edi, sumaPrimos

;pedir elementos de 0 hasta N-1
leer_siguiente:
    ;Pedimos al usuario que ingrese el elemento
    xor eax,eax
    PutStr pedirElem
    inc esi ;incrementamos esi (indice) en 1
    PutLInt esi ;imprimimos el indice aumentado
    dec esi ;decrementamos esi en 1
    ; ----------------------------
    PutStr pedirElem2 
    GetInt word[ebx + esi*2]   ;leemos el elemento
    mov ax, word[ebx + esi*2]
    mov [original], ax
    call esPrimo
    inc esi ;incrementamos el indice en 1
    loopnz leer_siguiente

;finalizar
finalizar:
    PutStr separador2
    PutStr output
    PutInt word[edi]
    nwln
    nwln
    mov eax,1
    int 80h

esPrimo:
    cmp eax, 1        
    je no_primo       
    mov ebx, 2        
    esPrimo_loop:
        mov ax,word[original]
        cmp ebx, eax  
        jge es_primo  
        xor edx, edx  
        div ebx       
        cmp edx, 0 
        je no_primo   
        inc ebx       
        jmp esPrimo_loop
    es_primo:
        add word[edi], ax ; [sumaPrimos] += eax
    no_primo:
        ret
