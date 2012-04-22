#include <stdio.h>

void main(int argc, char **argv) {
	char* runner;

	for(runner=*(argv + 1);*runner!=0; runner++);

	for(runner--;runner>=*(argv + 1); runner--){
		putchar(*runner);
	}
}
