[BITS 16]

global _BTHEX

segment _TEXT CLASS=CODE

_BTHEX:

        push bp
        mov bp, sp
        push si
        push bx

        xor bh, bh
        mov si, digits
        mov bl, [bp+0x04]
        and bl, 0x0F
        add si, bx
        mov ah, [si]
        mov si, digits
        mov bl, [bp+0x04]
        shr bl, 0x04
        add si, bx
        mov al, [si]

        pop bx
        pop si
        pop bp

        ret

segment _DATA CLASS=DATA

        digits db '0123456789ABCDEF'
