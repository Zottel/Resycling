[BITS 16]

global _main

segment _TEXT CLASS=CODE

_main:
  
    .eingabe_schleife:
        ;Lese Zeichen, beende einlsen bei leerer Eingabe
        call readChars
        cmp al,0x0d
        je .e_ende
        
        ;Reserviere einen Paragraphen pro Listeneintrag
        push ax
        mov ah, 0x48
        mov bx, 0x01
        int 0x21
        
        ;Erzeugen Listeneintrag
        mov es, ax
        xor di, di
        pop ax
        stosw
        mov ax, [prev_ptr]
        stosw
        mov [prev_ptr], es

        jmp .eingabe_schleife

    .e_ende:

    .ausgabe_schleife:
        ;Ausgeben bis Nullpointer
        cmp WORD [prev_ptr], 0
        je .a_ende

        ;Wert Laden und Ausgeben
        mov ds, [prev_ptr]
        xor si,si
        lodsw
        call writeChars
        call endl

        ;Pointer auf vorheriges Element laden
        push WORD [prev_ptr]
        lodsw
        mov [prev_ptr], ax

        ;Speicher freigeben
        pop es
        mov ah, 0x49
        int 0x21

        jmp .ausgabe_schleife

    .a_ende:
        mov ah, 0x4c
        int 0x21

readChars:
    ;String mit 2 Zeichen einlesen und in ax schreiben
    mov ah, 0x0a
    mov BYTE [chars], 3
    mov dx, chars
    int 0x21
    
    mov si, chars+2
    lodsw

    push ax
    call endl
    pop ax

    ret

writeChars:
    ;String in ax ausgeben
    push ax
    xor dx, dx
    mov dl, al
    mov ah, 0x02
    int 0x21

    pop ax
    xor dx, dx
    mov dl, ah
    mov ah, 0x02
    int 0x21

    ret

endl:
    mov ah, 0x02
    mov dl, 0x0d
    int 0x21
    mov dl, 0x0a
    int 0x21

    ret

segment _DATA CLASS=DATA

chars: times 5 db 0
prev_ptr: dw 0
