
;Nombre : logaritmo_entero.asm
;Proposito : Calcula el logaritmo entero de un numero entero
;Autores :  - Valeriano Huacarpuma Luigui Fernando - 211362
;           - Prieto Cardoso David Fernando - 210179
;FCreacion : 22/07/2023
;FModific. : ---
;Compilar : nasm -f elf logaritmo_entero.asm
; Enlazar : ld -m elf_i386 -s -o logaritmo_entero logaritmo_entero.o io.o
; Ejecutar : ./logaritmo_entero

%include "io.mac"

section .data
	proposito: db	"LOGARITMO ENTERO DE UN NUMERO N",10,0
    p2: db "=====================",10,0
	N: db	"Ingrese un numero entero : ",0
	b: db	"Ingrese la base : ",0
	resultado1: db "El logaritmo entero de ", 0
	resultado2: db " en base ", 0
	resultado3: db " es = ", 0
	resultadobasemenor1:	db	"El resultado es indefinido",0
section .text
	global _start
	
_start:
	;--inicializar registros
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx 
	
	PutStr proposito
	PutStr p2
	PutStr N
	GetLInt esi
	PutStr b
	GetLInt eax
	
	cmp eax, 1
	jle basemenor1
	cmp esi, 0
	jle basemenor1
    mov edi, 1 ;contador para la potencia 
	mov ecx, 0 ;contador de resultado
	mov ebx, eax ; guardar el valor de la base
	call log
	dec ecx
	PutStr resultado1
	PutLInt esi
	PutStr resultado2
	PutLInt ebx
	PutStr resultado3
	PutLInt ecx
	nwln
	jmp final
final:	
	mov eax, 1
	int 80h
	
log:
	inc ecx
	mov edx, eax ;Salvar el resultado de la potencia
	mov eax, ebx ;Recuperar el valor de la base
	mov edi, 1
	cmp edx, esi
	jle bucle ;menor o igual
	
	ret
bucle:
	mul ebx
	inc edi
	cmp edi, ecx  
	jle bucle
	jmp log
	
basemenor1:
	PutStr resultadobasemenor1
	nwln
	jmp final