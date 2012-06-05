#include <stdio.h>

#define X_RES 80
#define Y_RES 25

void putcchar(char val, char color, int x, int y) {

        char far *video = (char far*)0xB8000000;

        int offset = 2*(y*X_RES+x);

        *(video+offset) = val;
        *(video+offset+1) = color;
}

void main() {
        
        putcchar('A',0x0a,0,0);
        putcchar('B',0x0c,79,0);
        putcchar('C',0x0e,79,24);
        putcchar('D',0x09,0,24);

        getch();

        putcchar(0,0x07,0,24);
}

