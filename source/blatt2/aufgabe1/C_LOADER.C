#include <stdio.h>
#include "C_ADD.H"

void main() {

        int val1,val2;
        scanf("%d %d", &val1, &val2);
        add(&val1,val2);
        printf("%d\n", val1);
}

