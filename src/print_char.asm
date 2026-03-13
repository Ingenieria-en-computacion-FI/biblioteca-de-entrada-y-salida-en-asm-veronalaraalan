; =========================================
; Descripción:
;   Imprime en pantalla el carácter almacenado
;   en el registro AL.
;
; Entrada:
;   AL = carácter a imprimir
;
; Salida:
;   Ninguna
; =========================================

SECTION .bss
char_buffer resb 1              ; buffer temporal de 1 byte para guardar el carácter

SECTION .text
global print_char

; -----------------------------------------
; print_char
; Imprime el carácter contenido en AL
; -----------------------------------------
print_char:

    push ebp                    ; guardar el valor anterior de EBP
    mov ebp, esp                ; crear marco de pila de la función

    ; Guardar el carácter que viene en AL dentro del buffer
    mov [char_buffer], al

    ; Llamada al sistema write
    ; eax = 4  -> sys_write
    ; ebx = 1  -> stdout
    ; ecx = dirección del buffer
    ; edx = 1  -> imprimir 1 byte
    mov eax, 4
    mov ebx, 1
    mov ecx, char_buffer
    mov edx, 1
    int 0x80

    mov esp, ebp                ; restaurar el puntero de pila
    pop ebp                     ; restaurar el EBP anterior
    ret                         ; regresar al programa llamador
