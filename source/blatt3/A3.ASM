[BITS 16]

org 0x100

main:
        xor ax, ax
        mov es, ax
        mov ax, WORD [es:0036]
        mov WORD [orig_off], ax
        mov ax, WORD [es:0038]
        mov WORD [orig_seg], ax

        ;Eigene ISR in IVT
        mov WORD [es:0036], kbd_isr
        mov WORD [es:0038], cs

        mov dx, 0x1000   ; 64kb im speicher behalten
        mov ah, 0x31     ; Im Speicher bleiben und beenden
        int 0x21

kbd_isr:
        sub sp,0x04

        push bx
        mov bx,sp
        push ax

        add bx, 0x04

        mov ax, [cs:orig_seg]
        mov [ss:bx], ax    

        sub bx, 0x02

        mov ax, [cs:orig_off]
        mov [ss:bx], ax

        push es
        push ds
        push si
        push di
        call print_char
        pop di
        pop si
        pop ds
        pop es

        pop ax
        pop bx

        retf

print_char:
        mov ax, 0xb800  ;Anfang Grafikspeicher
        mov es, ax      
        mov di, 0x0f9e  ;Position 80,25
        mov si, char
        mov bx, cs
        mov ds, bx
        movsw           ;Mov von ds:si nach es:di

        cmp BYTE [cs:char], 'Z'    ; "Z" erreicht?
        jne .next
        mov BYTE [cs:char], 0x40    ; ein Zeichen vor "A"
        .next:
        inc BYTE [cs:char]          ; Naechstes Zeichen

        ret

char db 'A', 0x0a
orig_off dw 0
orig_seg dw 0

