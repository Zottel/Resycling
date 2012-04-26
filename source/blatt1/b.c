#include "errno.h"
#include "stdlib.h"
#include "stdio.h"

void main(int argc, char *argv[]) {
	int zahl1, zahl2, zaehler;

	if(argc != 3) {
		fprintf(stderr, "Ungültiger Aufruf.\n Erwartet: %s <Zahl 1> <Zahl 2>\n", argv[0]);
		exit(1);
	}
	
	zahl1 = atoi(argv[1]);
	zahl2 = atoi(argv[2]);
	
	if(errno != 0) {
		fprintf(stderr, "Ungültige Zahlen(%d).\n", errno);
		exit(2);
	}
	
	// Abfangen eines Überlaufes fehlt hier.
	
	for(zaehler = 0; zaehler < zahl2; zaehler++, zahl1++) {
		printf("%10d | %10d\n", zahl1, zahl1*zahl1);
	}
}
