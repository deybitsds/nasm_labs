;Nombre : cargarVector.asm
;Proposito : carga enteros en un arreglo unidimensional
;Autor : Edwin Carrasco (basado en [2])
;FCreacion : 28/07/2008
;FModific. : 08/10/2019
;compilar : nasm -f elf cargarVector.asm
; ld –m elf_i386 -s -o cargarVector cargarVector.o io.o
; ./cargarVector
%include "io.mac"
MAX_SIZE EQU 5
section .data
    mensaje db "ESTE PROGRAMA PERMITE INGRESAR HASTA 05 ENTEROS A UN VECTOR",10,0
    entrada db "Ingrese 5 valores diferentes de cero ",13 
    db "(si ingresa cero, termina la lectura de datos):",10, 0
    salida db "Los elementos del vector son: ",10,0
    imprimirTab db "",9,0
    invitacion db "Ingrese el elemento ", 0
    pedirDatos db " del vector: ", 0
    arregloVacio db "El vector esta vacio. ",0
    pregunta db "Terminar? (S/N): ",0
section .bss
    arreglo resd MAX_SIZE
section .text
    global _start
_start:
    PutStr mensaje
leer_datos:
    PutStr entrada ; solicitar datos
    xor esi,esi ; ESI = 0 (ESI se utiliza como indice)
    mov ecx,MAX_SIZE
leer_siguiente:
    PutStr invitacion
    PutLInt esi
    PutStr pedirDatos
    GetLInt eax
    mov [arreglo+esi*4],eax
    inc esi ; incrementar indice de arreglo
    cmp eax,0 ; se ingreso un cero?
    loopne leer_siguiente ; iterar no mas de MAX_SIZE veces
exit_loop:
    ; si la entrada termina con un cero,
    ; decrementar esi para mantener el tamaño del arreglo
    jnz omitir
    dec esi
omitir:
    mov ecx, esi ; esi almacena el tamaño del arreglo
    jecxz arreglo_Vacio ; si ecx = 0, el arreglo esta vacio
    xor esi,esi ; inicializar indice a cero
    PutStr salida
mostrar_siguiente:
    PutLInt [arreglo+esi*4]
    PutStr imprimirTab
    inc esi
    nwln
    loop mostrar_siguiente
    jmp short preguntar
arreglo_Vacio:
    PutStr arregloVacio ; mostrar mensaje de arreglo vacio
    nwln
preguntar:
    nwln
    PutStr pregunta ; preguntar al usuario si desea terminar
    GetCh AL
    cmp AL,"S" ; si la respuesta no es 'S'
    jne leer_datos ; repetir el bucle
terminado:
;volver al sistema
    mov eax,1
    int 80h