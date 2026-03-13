; =========================================
; Descripción:
;   Lee un carácter desde la entrada estándar
;   y lo devuelve en el registro AL.
;
; Entrada:
;   Ninguna
;
; Salida:
;   AL = carácter leído
; =========================================

SECTION .bss
char_buffer resb 1              ; buffer temporal de 1 byte para guardar el carácter leído

SECTION .text
global scan_char

; -----------------------------------------
; scan_char
; Lee un carácter desde teclado y lo regresa en AL
; -----------------------------------------
scan_char:

    push ebp                    ; guardar el valor anterior de EBP
    mov ebp, esp                ; crear marco de pila de la función

    ; Llamada al sistema read
    ; eax = 3  -> sys_read
    ; ebx = 0  -> stdin
    ; ecx = dirección del buffer
    ; edx = 1  -> leer 1 byte
    mov eax, 3
    mov ebx, 0
    mov ecx, char_buffer
    mov edx, 1
    int 0x80

    ; Colocar el carácter leído en AL
    mov al, [char_buffer]

    mov esp, ebp                ; restaurar el puntero de pila
    pop ebp                     ; restaurar el EBP anterior
    ret                         ; regresar al programa llamador
