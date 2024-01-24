;;; ----------------------------------------------------------
;;; io.asm
;;; D. T.
;;; A simple collection of I/O routines
;;; To use, simply add
;;;
;;;     %include "io.asm"
;;; 
;;; at the end of your program, and make sure the file
;;; io.asm in in your directory when assembling and linking
;;; your program.
;;; ----------------------------------------------------------


;;; ----------------------------------------------------------
;;; newLine:     puts the cursor on a new line
;;; ----------------------------------------------------------
       
newLine:
        section .data
endl    db      0x0a
        section .text
        pusha
        mov     eax,4           ; SYS_WRITE
        mov     ebx,1           ; STDOUT
        mov     edx,1           ; 1 char
        lea     ecx,[endl]      ; end-of-line string
        int     0x80
        popa
        ret
        
;;; ----------------------------------------------------------
;;; Decimal: prints the contents of eax in decimal
;;; ----------------------------------------------------------
Decimal:        
;;; saves all the registers so that they are not changed by the function

                section .bss
        decstr  resb            10
        ct1     resd            1       ;  to keep track of the 
                ;;                         size of the string

                section .text

                pusha
                mov             dword[ct1],0    ; assume initially 0
                mov             edi,decstr      ; edi points to decstring
                add             edi,9           ; moved to the last elt of string
                xor             edx,edx         ; clear edx for division
goback1:
                mov             ebx,10
                div             ebx
                add             edx,'0'        ;  converts to ascii
                mov             byte[edi],dl
                dec             edi
                inc             dword[ct1]
                xor             edx,edx
                cmp             eax,0
                jne             goback1

                
                mov             eax,4           ; sys_write
                mov             ebx,1           ; 1
                mov             edx,[ct1]
                lea             ecx,[edi+1]
                int             0x80            ; print

;;; restores the registers
                popa
                ret
        
