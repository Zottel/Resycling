#include "o2.h"
#include <stdio.h>

void main() {
	int val1,val2;
	scanf("%d %d", &val1,&val2);
	add(&val1,val2);
	printf("%d", val1);
}

