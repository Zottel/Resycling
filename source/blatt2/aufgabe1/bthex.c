#include <stdio.h>

int BTHEX(unsigned char a) {

    int res;
    char* digits = "0123456789ABCDEF";

    asm {

        mov si, digits
        mov bl, a
        and bl, 0x0F
        add si, bx
        mov ah, [si]
        mov si, digits
        mov bl, a
        shr bl, 0x04
        add si,bx
        mov al, [si]
        mov res, ax
    };

    return res;
}
