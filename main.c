/* Welcome to the Interactive C Tutorial.
Start by choosing a chapter and
write your code in this window. */

#include <stdio.h>
#include <string.h>

int showhelp() {
	
	printf("Usage:\n");
	printf("\ttp0 -h\n");
	printf("\ttp0 -V\n");
	printf("\ttp0 [options]\n");
	printf("\n");
	printf("Options:\n");
	printf("\t-V --version\tPrint version and quit.\n");
	printf("\t-h --help\tPrint this information.\n");
	printf("\t-i --input\tLocation of the input file.\n");
	printf("\t-o --output\tLocation of the output file.\n");
	printf("\n");
	printf("Examples:\n");
	printf("\ttp0 -i ~/input ~/output");

}

int showargs(int argc, char **argv) {
	for (int i = 0; i < argc; ++i) {
		printf("argv[%d]: %s\n", i, argv[i]);
	}
}

int showversion() {
	printf("tp0 version: 0.0.1b");
}

int procesar(char* pathinput, char* pathoutput) {
	printf("Procesando entrada: %s, salida: %s...", pathinput, pathoutput);
}

int main(int argc, char **argv) {
	
	if (argc == 1) {
		printf("No input files. Try tp0 -h");
	} else
	if (argc == 2) {
		if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
			showhelp();
		} else
		if (strcmp(argv[1], "-v") == 0 || strcmp(argv[1], "--version") == 0) {
			showversion();
		}
	} else
	if (argc == 5) {
		if ((strcmp(argv[1], "-i") == 0 || strcmp(argv[1], "--input") == 0) && 
			(strcmp(argv[3], "-o") == 0 || strcmp(argv[3], "--output") == 0))
			procesar(argv[2], argv[4]);
	}
	return 0;
}
    
