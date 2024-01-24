;Nombre : nrosFelices.asm
;Proposito : MUESTRA LOS NUMEROS FELICES EN UNA MATRIZ M X N
;Autores :  - Valeriano Huacarpuma Luigui Fernando - 211362
;           - Prieto Cardoso David Fernando - 210179
;FCreacion : 05/08/2023
;FModific. : ---
;Compilar :
; nasm -f elf nrosFelices.asm -Wall
; ld -m elf_i386 -s -o nrosFelices nrosFelices.o io.o
; ./nrosFelices

%include "io.mac"

section .data
    msg         db " <<<BUSCAR NUMEROS FELICES EN UN ARREGLO DE MxN>>> " ,10,0
    msgFila: db "Ingrese el nro de filas de la matriz : ",0
	msgColumna: db "Ingrese el nro de columnas de la matriz : ",0
    salida      db "La matriz es : ",10,0
    imprimirTab db "",9,0
    imprimirEsp db " ",0
    msgElementos: db "Ingrese los elementos de uno en uno (fila por fila) : ",10,0
    msgPosicion db ", el indice del elemento es : (",0
    imprimirComa db ",",0
    imprimirParentesisCerradura db ")",0
    msgSalida: db "El numero ", 0
    msgSalida1: db " es feliz", 0

section .bss
    arreglo resd 1000
    arregloResultados resd 1000
    a resd 1
    i resd 1
    j resd 1
    auxi resd 1
    auxj resd 1
section .text
    global _start

_start:
    PutStr msg
    leer_datos:
        xor esi,esi         ; ESI = 0 (ESI se utiliza como indice)
        xor edx,edx
        PutStr msgFila      ; solicitar datos
        GetLInt eax
        mov [i],eax
        PutStr msgColumna
        GetLInt eax
        mov [j],eax
        mov ebx,1       ;contadorFila
        PutStr msgElementos
        
    leer_filas:
        mov ecx,1       ;contador Columna
        leer_columnas:
            ;Leer datos
            GetLInt eax
            mov [arreglo+ESI*4], eax
            inc esi
            inc ecx
            cmp ecx,[j]      
            jna leer_columnas       ;saltar si es menor o igual
        inc ebx
        cmp ebx,[i]              
        jna leer_filas              ;saltar si es menor o igual
    
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
		PutLInt [arreglo+ESI*4]
		PutStr msgSalida1
		PutStr msgPosicion
		PutLInt [auxi]
		PutStr imprimirComa
		PutLInt [auxj]
		PutStr imprimirParentesisCerradura
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
    
