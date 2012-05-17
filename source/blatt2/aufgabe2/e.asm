[BITS 16]

global _main
extern _scanf
extern _printf

segment _TEXT CLASS=CODE

_main:
    ;Wert einlesen
    push seg wert
    push wert
    push seg fstring
    push fstring
    call far _scanf
    add sp, 0x08

    ;Debug
    push WORD [wert]
    push seg astring
    push astring
    call far _printf
    add sp, 0x05

    ;Speicher nicht freigeben
    mov ah, 0x31
    mov dx, WORD [wert]
    shl dx , 0x06
    int 0x21

segment _DATA CLASS=DATA

    fstring db '%d', 0
    astring db 'Using %dKB', 13, 10, 0
    wert dw 0
