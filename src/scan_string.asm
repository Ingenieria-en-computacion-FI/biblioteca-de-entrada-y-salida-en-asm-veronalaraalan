; =========================================
; Descripción:
;   Lee una cadena desde la entrada estándar
;   y la guarda en el buffer indicado.
;
; Entrada:
;   EAX = dirección del buffer destino
;   EBX = tamaño máximo del buffer
;
; Salida:
;   El buffer queda con una cadena terminada en 0
; =========================================

SECTION .text
global scan_string

; -----------------------------------------
; scan_string
; Lee una cadena desde stdin
;
; Entrada:
;   EAX = buffer destino
;   EBX = tamaño máximo del buffer
; -----------------------------------------
scan_string:

    push ebp                    ; guardar el valor anterior de EBP
    mov ebp, esp                ; crear marco de pila de la función

    ; Verificar que el tamaño del buffer sea válido
    ; Si EBX <= 0, no se puede guardar nada
    cmp ebx, 0
    jle done

    mov esi, eax                ; ESI = dirección del buffer destino
    mov edi, ebx                ; EDI = tamaño máximo del buffer

    ; Reservar 1 byte para el terminador nulo
    dec edi                     ; bytes máximos a leer = tamaño - 1

    ; Si después de restar queda negativo, salir
    cmp edi, 0
    jl done

    ; Llamada al sistema read
    ; eax = 3  -> sys_read
    ; ebx = 0  -> stdin
    ; ecx = dirección del buffer
    ; edx = cantidad máxima a leer
    mov eax, 3
    mov ebx, 0
    mov ecx, esi
    mov edx, edi
    int 0x80

    ; EAX contiene la cantidad de bytes leídos
    ; Si no se leyó nada, dejar cadena vacía
    cmp eax, 0
    jle empty_string

    mov edx, eax                ; EDX = número de bytes leídos
    xor ecx, ecx                ; ECX = índice para recorrer el buffer

search_newline:
    ; Si ECX >= bytes leídos, no se encontró '\n'
    cmp ecx, edx
    jge put_zero_end

    ; Revisar si el byte actual es salto de línea (ASCII 10)
    cmp byte [esi + ecx], 10
    je put_zero_here

    inc ecx
    jmp search_newline

put_zero_here:
    ; Reemplazar el salto de línea por terminador nulo
    mov byte [esi + ecx], 0
    jmp done

put_zero_end:
    ; Si no hubo '\n', agregar 0 al final de lo leído
    mov byte [esi + edx], 0
    jmp done

empty_string:
    ; Si no se leyó nada, dejar la cadena vacía
    mov byte [esi], 0

done:
    mov esp, ebp                ; restaurar el puntero de pila
    pop ebp                     ; restaurar el EBP anterior
    ret                         ; regresar al programa llamador
