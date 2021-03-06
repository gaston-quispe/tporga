#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define VERSION "0.1.0beta"
typedef enum {
	STDIN_STDOUT,
	ARCHIVO_STDOUT,
	STDIN_ARCHIVO,
	ARCHIVO_ARCHIVO
} modo_entrada_salida;

int es_capicua(char* palabra)
{
	size_t izq = 0, longitud;
	longitud = strlen(palabra);
	if (longitud == 0)
		return 0;

	for (izq = 0; izq < longitud / 2; izq++) {
		int der = longitud - izq - 1;
		if (tolower((int)palabra[izq]) != tolower((int)palabra[der]))
			return 0;
	}
	return 1;
}

int caracter_valido(int caracter)
{
	int minuscula = tolower((int)caracter);
	if (
		(minuscula > 96 && minuscula < 123) ||
		(minuscula > 47 && minuscula < 58)  ||
	  	minuscula == 45 || minuscula == 95)
	{
		return 1;
	}
	return 0;
}

int leer_palabra_valida(char** str, FILE* fp) {
	char* buffer = NULL;
	size_t buffer_size = 128;
	int c;
	size_t p_comienzo = 0;
	size_t p_longitud = 0;
	buffer = malloc(buffer_size);
	if (!buffer) {
		fprintf(stderr, "Error al reservar memoria");
		exit(1);
	}
	// Avanzar puntero hasta encontrar el comienzo de una palabra valida
	while (!feof(fp) && !caracter_valido(c = fgetc(fp))) {
		if (ferror(fp))
			fprintf(stderr, "Error al leer archivo de entrada");
		p_comienzo++;
	}

	// Avanzar puntero hasta que finalice la palabra valida
	while (!feof(fp) && caracter_valido(c)) {
		if (p_comienzo + p_longitud + 1 == buffer_size) {
			buffer_size *= 2;
			buffer = realloc(buffer, buffer_size);
			if (!buffer) {
				fprintf(stderr, "Error al reservar memoria");
				exit(1);
			}
		}
		buffer[p_longitud++] = c;
		c = fgetc(fp);
		if (ferror(fp))
			fprintf(stderr, "Error al leer archivo de entrada");
	}
	buffer[p_longitud] = '\0';
	*str = buffer;

	if (feof(fp) || p_longitud == 0)
		return 0; //No se encontro palabra valida
	return 1; //Se encontro palabra valida
}

int procesar_archivo(FILE* archivo_entrada, FILE* archivo_salida)
{
	char* palabra_valida;

	if (!archivo_entrada || !archivo_salida) {
		if (archivo_entrada) fclose(archivo_entrada);
		if (archivo_salida)  fclose(archivo_salida);
		return 0;
	}

	while (leer_palabra_valida(&palabra_valida, archivo_entrada)) {
		if (es_capicua(palabra_valida)) {
		 	fprintf(archivo_salida, "%s\n", palabra_valida);
			if (ferror(archivo_salida))
  				fprintf(stderr, "Error al escribir en archivo de salida\n");
		}
		free(palabra_valida);
	}

	return 1;
}

void mostrar_usage()
{
	printf("Usage:\n");
	printf("\ttp0 -h\n");
	printf("\ttp0 -V\n");
	printf("\ttp0 [options]\n");
	printf("\n");
	printf("Options:\n");
	printf("\t-v --version\tPrint version and quit.\n");
	printf("\t-h --help\tPrint this information.\n");
	printf("\t-i --input\tLocation of the input file.\n");
	printf("\t-o --output\tLocation of the output file.\n");
	printf("\n");
	printf("Examples:\n");
	printf("\ttp0 -i ~/input ~/output\n");
}

void mostrar_version()
{
	printf("tp0 version: %s\n", VERSION);
}

int error_parametros_incorrectos()
{
	fprintf(stderr, "erro fatal: Los parametros son incorrectos!\n");
	mostrar_usage();
	exit(1);
}

int main(int argc, char **argv)
{
	size_t i;
	int version = 0;
	int help = 0;
	int input = 0;
	int output = 0;
	char* input_path;
	char* output_path;
	FILE* input_handler = NULL;
	FILE* output_handler = NULL;
	modo_entrada_salida entrada_salida = 0;

	for (i = 1; i < argc; i++) {
		if (strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "--version") == 0) {
			version++;
		} else if (strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0) {
			help++;
		} else if (strcmp(argv[i], "-i") == 0 || strcmp(argv[i], "--input") == 0) {
			input++;
			if (i + 1 <= argc - 1) {
				i++;
				input_path = argv[i];
			} else {
				error_parametros_incorrectos();
			}
		} else if (strcmp(argv[i], "-o") == 0 || strcmp(argv[i], "--output") == 0) {
			output++;
			if (i + 1 <= argc - 1) {
				i++;
				output_path = argv[i];
			} else {
				error_parametros_incorrectos();
			}
		} else {
			error_parametros_incorrectos();
		}
	}

	if (version > 1 || help > 1 || input > 1 || output > 1) {
		error_parametros_incorrectos();
	}

	if (help == 1) {
		if (argc == 2) {
			mostrar_usage();
			exit(0);
		} else {
			error_parametros_incorrectos();
		}
	}

	if (version == 1) {
		if (argc == 2) {
			mostrar_version();
			exit(0);
		} else {
			error_parametros_incorrectos();
		}
	}

	if     ((input == 0 && output == 0) ||
		(input == 0 && output == 1 && strcmp(output_path, "-") == 0) ||
		(input == 1 && output == 0 && strcmp(input_path,  "-") == 0) ||
		(input == 1 && output == 1 && strcmp(input_path,  "-") == 0 &&
					      strcmp(output_path, "-") == 0))
			entrada_salida = STDIN_STDOUT;
	else
	if     ((input == 0 && output == 1 && strcmp(output_path, "-") != 0) ||
	 	(input == 1 && output == 1 && strcmp(input_path,  "-") == 0 &&
		 		              strcmp(output_path, "-") != 0))
			entrada_salida = STDIN_ARCHIVO;
	else
	if     ((input == 1 && output == 0 && strcmp(input_path,  "-") != 0) ||
	 	(input == 1 && output == 1 && strcmp(input_path,  "-") != 0 &&
					      strcmp(output_path, "-") == 0))
			entrada_salida = ARCHIVO_STDOUT;
	else
	if 	(input == 1 && output == 1 &&
		strcmp(input_path,  "-") != 0 &&
		strcmp(output_path,  "-") != 0)
		 	entrada_salida = ARCHIVO_ARCHIVO;
	else
		error_parametros_incorrectos();

	switch (entrada_salida) {
		case STDIN_STDOUT:
			input_handler = stdin;
			output_handler = stdout;
			break;
		case ARCHIVO_STDOUT:
			input_handler = fopen(input_path, "r");
			output_handler = stdout;
			if (!input_handler) {
				fprintf(stderr, "Error en apertura de archivo");
				return 1;
			}
			break;
		case STDIN_ARCHIVO:
			input_handler = stdin;
			output_handler = fopen(output_path, "w");
			if (!output_handler) {
				fprintf(stderr, "Error en apertura de archivo");
				return 1;
			}
			break;
		case ARCHIVO_ARCHIVO:
			input_handler = fopen(input_path, "r");
			output_handler = fopen(output_path, "w");

			if (!input_handler || !output_handler) {
				if (input_handler) fclose(input_handler);
				if (output_handler) fclose(output_handler);
				fprintf(stderr, "Error en apertura de archivo");
				return 1;
			}
			break;
	}

	procesar_archivo(input_handler, output_handler);

	switch (entrada_salida) {
		case STDIN_STDOUT:
			break;
		case ARCHIVO_STDOUT:
			fclose(input_handler);
			break;
		case STDIN_ARCHIVO:
			fclose(output_handler);
			break;
		case ARCHIVO_ARCHIVO:
			fclose(input_handler);
			fclose(output_handler);
			break;
	}

	return 0;
}
