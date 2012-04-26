#include "stdio.h"

void main() {
	int zahl1, zahl2, zaehler;
	if(scanf("%d %d", &zahl1, &zahl2)) {
		for(zaehler = 0; zaehler < zahl2; zaehler++, zahl1++) {
			printf("%10d | %10d\n", zahl1, zahl1*zahl1);
		}
	} else {
		fprintf(stderr, "Falsche Eingabe, erwartete: <zahl 1> <zahl 2>");
	}
}
