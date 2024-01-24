
;Nombre : raiz_entera.asm
;Proposito : Calcula la raiz entera de un numero entero
;Autores :  - Valeriano Huacarpuma Luigui Fernando - 211362
;           - Prieto Cardoso David Fernando - 210179
;FCreacion : 22/07/2023
;FModific. : ---
;Compilar : nasm -f elf raiz_entera.asm
; Enlazar : ld -m elf_i386 -s -o raiz_entera raiz_entera.o io.o
; Ejecutar : ./raiz_entera

%include "io.mac"

section .data
	proposito: db	"CALCULAR LA RAIZ CUADRADA ENTERA DE UN ENTERO N",10,0
    p2 : db "=====================",10,0
	n: db	"Ingrese un numero entero : ",0
	resultado1: db "La raiz entera de ", 0
	resultado2: db " es = ", 0
	msgnegativo: db "Los numeros negativos no tienen raiz entera",10,0
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
	PutStr n
	GetLInt esi
	
	cmp esi, -1
	jle negativo
	
	mov eax, 1
	mov edi, 1
	call raiz
	
	dec edi
	PutStr resultado1
	PutLInt esi
	PutStr resultado2
	PutLInt edi
    nwln
	jmp final
final:
	mov eax, 1
	int 80h
	
raiz:
	mul eax
	cmp eax, esi
	jle bucle ;menor o igual
    ret 

bucle:
    inc edi
    mov eax, edi
    jmp raiz

negativo:   
    PutStr msgnegativo
    jmp final