#include <stdio.h>

#define X_RES 80
#define Y_RES 25

char far* getpageptr() {
        unsigned int far *pageoffset = (unsigned int far*) 0x0040004e;

        return 0xB8000000+*pageoffset;
}

void putcchar(char val, char color, int x, int y) {

        char far *video = getpageptr();

        int offset = 2*(y*X_RES+x);
        
        *(video+offset) = val;
        *(video+offset+1) = color;
}

void setactivepage(char page) {

        _AH = 0x05;
        _AL = page;
        
        asm {
                INT 0x10
        }
}

void main(int argc, char** argv) {

        setactivepage(atoi(argv[1]));
        
        putcchar('A',0x0a,0,0);
        putcchar('B',0x0c,79,0);
        putcchar('C',0x0e,79,24);
        putcchar('D',0x09,0,24);

        delay(5000);

        setactivepage(0);

        putcchar(0,0x07,0,24);
}

