


;Nombre : nrosFelices.asm
;Proposito : MUESTRA LOS NUMEROS FELICES EN UNA MATRIZ M X N
;Autores :  - Valeriano Huacarpuma Luigui Fernando - 211362
;           - Prieto Cardoso David Fernando - 210179
;FCreacion : 05/08/2023
;FModific. : ---
;Compilar :
; nasm -f elf nroFeliz.asm -Wall
; ld -m elf_i386 -s -o nroFeliz nroFeliz.o io.o
; ./nroFeliz

%include "io.mac"
section .bss
    arreglo resd 1000
    arregloResultados resd 1000
    m resw 1 ; Numero de filas
    n resw 1 ; numero de columnas
    i resw 1 ; Indice de filas
    j resw 1 ; Indice de columnas
    a resd 1
    auxi resd 1
    auxj resd 1
    eaxx resd 1
    ebxx resd 1
    ecxx resd 1
    edxx resd 1
    edix resd 1
    esix resd 1
    elemento resw 1
    matrizA resw 200 ; Reservar 200 palabras de 2 bytes
    matrizB resw 200

section .data
    msg         db " <<<BUSCAR NUMEROS FELICES EN UN ARREGLO DE MxN>>> " ,10,0
    msgFila1: db "Ingrese el nro de filas de la matriz : ",0
	msgColumna1: db "Ingrese el nro de columnas de la matriz : ",0
    salida      db "La matriz es : ",10,0
    imprimirTab db "",9,0
    imprimirEsp db " ",0
    msgElementos: db "Ingrese los elementos de uno en uno (fila por fila) : ",10,0
    msgPosicion db " -- EN EL INDICE (",0
    imprimirComa db ",",0
    imprimirParentesisCerradura db ")",0
    msgSalida: db "EL NÚMERO ", 0
    msgSalida1: db " ES FELIZ", 0
    titulo db "APP PARA MOSTRAR NROS FELICES EN UNA MATRIZ M x N",10,0
    separarador db  "=================================================",10,0 
    separadador2 db "--------",10,0
    msgFilas db "Ingrese M : ",0,10
    msgColumnas db "Ingrese N : ", 0,10
    tituloA db "MATRIZ",10,0
    tituloB db "MATRIZ B",10,0
    msgAB db "A + B",10,0
    separadador3 db "-----", 10,0
    msgFila db "Elemento Fila ",0
    msgColumna db " y Columna ",0
    puntos db " : ",0,10
    msjCambiar db "Cambiar Matrices (S/n): ",0,10
    msjSumar db "Sumar Matrices (S/n): ",0,10
    tab db "",9,0
    tituloFELICES db "NÚMEROS FELICES",10,0


    
    ; ------------------------------
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

; LEER MATRIZ 
leer_matriz:
    PutStr separarador
    ;IMPRIMIR INFO A
    
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

; MOSTRAR FELICES
    ;Mostrar matriz FELICES
mostrar_felices:
    PutStr tituloFELICES
    PutStr separadador2
bucle_filas2FELICES:
    mov ebx, matrizA
    mov word[j], 0
bucle_columnas2FELICES:
    ;eax es el indice de la matriz y cada elemento es de 2 bytes
    call GuardarTodo
    mov ax, word[ebx+2*eax]
    mov [elemento],eax
    call NroFeliz
    call ReestablecerTodo ;Imprime un espacio despues de cada elemento
    inc eax
    inc word[j]
    mov cx, word[j]
    cmp cx, word[n]
    jb bucle_columnas2FELICES
    inc word[i]
    mov cx, word[i]
    cmp cx, word[m]
    jb bucle_filas2FELICES
    nwln
    mov eax, 0
    mov word[i], 0
    mov word[j], 0

finalizar:
    nwln 
    mov eax,1
    int 80h

_start12:
    PutStr msg
    leer_datos12:
        xor esi,esi         ; ESI = 0 (ESI se utiliza como indice)
        xor edx,edx
        PutStr msgFila1      ; solicitar datos
        GetLInt eax
        mov [i],eax
        PutStr msgColumna1
        GetLInt eax
        mov [j],eax
        mov ebx,1       ;contadorFila
        PutStr msgElementos
        
    leer_filas12:
        mov ecx,1       ;contador Columna
        leer_columnas12:
            ;Leer datos
            GetLInt eax
            mov [arreglo+ESI*4], eax
            inc esi
            inc ecx
            cmp ecx,[j]      
            jna leer_columnas12       ;saltar si es menor o igual
        inc ebx
        cmp ebx,[i]              
        jna leer_filas12              ;saltar si es menor o igual
    
    continunado:
    PutStr salida
    mov ecx,esi ;Guardar el nro de elementos para usarlos para mostrar
    xor esi,esi

    mostrarmatriz:              ; Mostrar matriz
        PutLInt [arreglo+ESI*4]
        PutStr imprimirEsp
        inc esi
        xor edx,edx
        mov eax,esi
        mov ebx,[j]
        div ebx                   ;Para saltar a la sgt x ejemplo en una matriz de 3x3 cuando el ebx tiene 6
        cmp edx,0
        jnz continuar
        nwln						; Cuando se cumple esa condicion se imprime una nueva linea para para que se vea como una matriz
        continuar:
        loop mostrarmatriz      ;ecx se decrementa

        xor esi,esi
        mov [auxi],esi           ;asignando 0 a auxiluares
        mov [auxj],esi

 
    buscar_filas:
        xor eax,eax
        mov [auxj],eax       ;contador Columna inicia en 0
        buscar_columnas:
            mov eax,[arreglo+esi*4]   
			call NroFeliz   
            IncrementarContadores:
            inc esi
            mov eax,1
            add [auxj],eax           ;incrementar columna
            mov eax,[auxj]
            cmp eax,[j]       
            jnae buscar_columnas        ;saltar si es distinto va de 0 a j-1
        mov eax,1
        add [auxi],eax
        mov eax,[auxi]
        cmp eax,[i]              
        jnae buscar_filas               ;saltar si es distinto va de 0 a i-1
		jmp terminado
		
	Feliz:
		PutStr msgSalida
		PutInt word[elemento]
		PutStr msgSalida1
        ; ACA
		PutStr msgPosicion
        inc word[i]
		PutInt [i]
        dec word[i]
        inc word[j]
		PutStr imprimirComa
		PutInt [j]
        dec word[j]
		PutStr imprimirParentesisCerradura
        ; ACA
		nwln
		ret
		
	No_Feliz:
		ret
	NroFeliz:
		xor ecx, ecx
		xor edi, edi
		mov ebx, 10
		cmp eax, 1
		je Feliz
		cmp eax, 4
		je No_Feliz
		cmp eax, 0
		je No_Feliz
		jmp Proceso
		
	Proceso:
		xor edx, edx
		div ebx
		mov edi, eax ;guardar el cociente
		mov eax, edx ;cambiar al residuo
		mul eax; Cuadrado
		add ecx, eax
		mov eax, edi ;recuperar el valor del cociente
		cmp eax, 0
		jne Proceso
		mov eax, ecx
		jmp NroFeliz
	
terminado:
	mov eax,1
	int 80h
    

















    
GuardarTodo:
    mov [eaxx],eax
    mov [ebxx],ebx
    mov [ecxx],ecx
    mov [edxx],edx
    mov [esix],esi
    mov [edix],edi
    ret

ReestablecerTodo:
    mov eax,[eaxx]
    mov ebx,[ebxx]
    mov ecx,[ecxx]
    mov edx,[edxx]
    mov esi,[esix]
    mov edi,[edix]
    ret 