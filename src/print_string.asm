; =========================================
; Descripción:
;   Imprime una cadena terminada en cero.
;
; Entrada:
;   EAX = dirección de la cadena
;
; Salida:
;   Ninguna
; =========================================

SECTION .text
global print_string

; -----------------------------------------
; print_string
; Imprime una cadena terminada en 0
; Entrada:
;   EAX = dirección de la cadena
; -----------------------------------------
print_string:

    push ebp                    ; guardar el valor anterior de EBP
    mov ebp, esp                ; crear marco de pila de la función

    mov esi, eax                ; ESI recorrerá la cadena desde su inicio
    xor edx, edx                ; EDX funcionará como contador de longitud = 0

count_loop:
    ; Revisar si ya llegamos al terminador nulo
    cmp byte [esi], 0
    je do_print

    ; Si no es fin de cadena, avanzar al siguiente carácter
    inc esi
    inc edx
    jmp count_loop

do_print:
    ; Llamada al sistema write
    ; eax = 4  -> sys_write
    ; ebx = 1  -> stdout
    ; ecx = dirección de la cadena
    ; edx = longitud calculada
    mov ecx, eax
    mov eax, 4
    mov ebx, 1
    int 0x80

    mov esp, ebp                ; restaurar el puntero de pila
    pop ebp                     ; restaurar el EBP anterior
    ret                         ; regresar al programa llamador
