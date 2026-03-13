; =========================================
; Descripción:
;   Imprime un salto de línea en pantalla.
;
; Entrada:
;   Ninguna
;
; Salida:
;   Ninguna
; =========================================

extern print_char
global newline

SECTION .text

; -----------------------------------------
; newline
; Imprime un salto de línea
; -----------------------------------------
newline:

    push ebp                    ; guardar el valor anterior de EBP
    mov ebp, esp                ; crear marco de pila de la función

    mov al, 10                  ; ASCII 10 = salto de línea '\n'
    call print_char             ; reutilizar la función print_char

    mov esp, ebp                ; restaurar el puntero de pila
    pop ebp                     ; restaurar el EBP anterior
    ret                         ; regresar al programa llamador
