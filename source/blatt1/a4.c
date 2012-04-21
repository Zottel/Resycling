#include <stdio.h>

void main() {
	printf("type    | groesse\n");
	printf("------- | -------\n");
	printf("char    | %-2d\n", sizeof(char));
	printf("integer | %-2d\n", sizeof(int));
	printf("short   | %-2d\n", sizeof(short));
	printf("float   | %-2d\n", sizeof(float));
	printf("double  | %-2d\n", sizeof(double));
}
