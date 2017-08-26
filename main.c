#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int show_usage()
{
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

int show_args(int argc, char **argv)
{
	for (int i = 0; i < argc; ++i) {
		printf("argv[%d]: %s\n", i, argv[i]);
	}
}

int show_version()
{
	printf("tp0 version: 0.0.1b");
}

int process(char* path_input, char* path_output)
{
	printf("Procesando entrada: %s, salida: %s...", path_input, path_output);
}

int error_msg_incorrect_parameters()
{
	fprintf(stderr, "fatal error: The parameters are incorrect!\n");
}

int error_incorrect_parameters()
{
	error_msg_incorrect_parameters();
	show_usage();
	exit(1);
}

int main(int argc, char **argv)
{
	int i;
	int version = 0;
	int help = 0;
	int input = 0;
	char* input_path;
	int output = 0;
	char* output_path;
	

	for (i = 1; i < argc; i++) {
		if (strcmp(argv[i], "-v") == 0) {
			version++;
		} else if (strcmp(argv[i], "-h") == 0) {
			help++;
		} else if (strcmp(argv[i], "-i") == 0) {
			input++;
			if (i + 1 <= argc - 1) {
				i++;
				input_path = argv[i];
			} else {
				error_incorrect_parameters();
			}
		} else if (strcmp(argv[i], "-o") == 0) {
			output++;
			if (i + 1 <= argc - 1) {
				i++;
				output_path = argv[i];
			} else {
				error_incorrect_parameters();
			}
		} else {
			error_incorrect_parameters();
		}
	}

	if (version > 1 || help > 1 || input > 1 || output > 1) {
		error_incorrect_parameters();
	}
	
	if (help == 1) {
		if (argc == 2) {
			show_usage();
			exit(0);
		} else {
			error_incorrect_parameters();
		}
	}

	if (version == 1) {
		if (argc == 2) {
			show_version();
			exit(0);
		} else {
			error_incorrect_parameters();
		}
	}

	if (input == 0 && output == 0) {
		printf("Utilizar stdin de entrada y stdout de salida");
	} else if ((input == 1 && output == 0) || (input == 1 && strcmp(output_path, "-") == 0)) {
		printf("Utilizar archivo %s de entrada y stdout de salida", input_path);
	} else if ((input == 0 && output == 1) || (strcmp(input_path, "-") == 0 && output == 1)) {
		printf("Utilizar stdin de entrada y archivo %s de salida", output_path);
	} else if (input == 1 && output == 1) {
		printf("Utilizar archivo %s de entrada y archivo %s de salida", input_path, output_path);
	} else {
		error_incorrect_parameters();
	}

	return 0;
}
    
