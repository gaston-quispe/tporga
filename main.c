#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define VERSION "0.0.3"
typedef enum {
	STDIN_STDOUT,
	ARCHIVO_STDOUT,
	STDIN_ARCHIVO,
	ARCHIVO_ARCHIVO
} handlers;

/*
str: 	Pointer to an array of chars where the string read is copied.
fp: 	Pointer to a FILE object that identifies an input stream.
	stdin can be used as argument to read from the standard input.
return: On success, the function returns str.
	If the end-of-file is encountered and the pointer returned
	is a null pointer.
*/
char* fgets2(char** str, FILE* fp)
{
	char* buffer = NULL;
	size_t buffer_size = 128;
	char c;
	size_t p = 0;
	buffer = malloc(buffer_size);

	while (1) {
		if (p + 1 == buffer_size) {
			buffer_size *= 2;
			buffer = realloc(buffer, buffer_size);
		}
		c = fgetc(fp);
		if (c == EOF || c == '\n')
			break;
		buffer[p++] = c;
	}
	buffer[p] = '\0';
	if (c == EOF)
		return NULL;

	*str = buffer;
	return buffer;
}

char* read_all_file(char** str, FILE* fp)
{
	char* buffer = NULL;
	size_t buffer_size = 128;
	char c;
	size_t p = 0;
	buffer = malloc(buffer_size);

	while ((c = fgetc(fp)) != EOF) {
		if (p + 1 == buffer_size) {
			buffer_size *= 2;
			buffer = realloc(buffer, buffer_size);
		}
		//printf("[%d]", (int)c);
		buffer[p++] = c;
	}
	buffer[p] = '\0';
	*str = buffer;
	return buffer;
}

int es_capicua(char* palabra)
{
	size_t izq = 0, longitud;
	longitud = strlen(palabra);
	if (longitud == 0 || longitud == 1)
		return 0;

	for (izq = 0; izq < longitud/2; izq++) {
		int der = longitud - izq -1;
		if (tolower((int)palabra[izq]) != tolower((int)palabra[der]))
			return 0;
	}
	return 1;
}

int caracter_valido(char caracter)
{
	char minuscula = tolower((int)caracter);
	if (
		(minuscula > 96 && minuscula < 123) ||
		(minuscula > 47 && minuscula < 58)  ||
	  	minuscula == 45 || minuscula == 95  ||
		minuscula == '\0')
	{
		return 1;
	}
	return 0;
}

/*
	Procesa un texto y devuelve uno nuevo con los caracteres
	no contemplados reemplazados por espacios.
*/
int quitar_caracteres_invalidos(char* texto, char** texto_valido)
{
	size_t i;
	*texto_valido = malloc(strlen(texto) + 1);
	strncpy (*texto_valido, texto, strlen(texto) + 1);

	for (i = 0; i < strlen(*texto_valido); i++)
		if (!caracter_valido((*texto_valido)[i]))
			(*texto_valido)[i] = ' ';

	return 1;
}

int procesar_archivo(FILE* archivo_entrada, FILE* archivo_salida)
{
	char* linea;
	char* linea_valida;

	if (!archivo_entrada || !archivo_salida) {
		if (archivo_entrada) fclose(archivo_entrada);
		if (archivo_salida)  fclose(archivo_salida);
		return 0;
	}

	read_all_file(&linea, archivo_entrada);
	printf("xxx:%s", linea);
	quitar_caracteres_invalidos(linea, &linea_valida);
	//printf("yyy:%s", linea);

	char* palabra = strtok(linea_valida, " ");
	while (palabra) {
		if (es_capicua(palabra))
			fprintf(archivo_salida, "%s ", palabra);
		palabra = strtok(NULL, " ");
	}

	free(linea);
        free(linea_valida);

	return 1;
}

void show_usage()
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

void show_version()
{
	printf("tp0 version: %s\n", VERSION);
}

int error_incorrect_parameters()
{
	fprintf(stderr, "fatal error: The parameters are incorrect!\n");
	show_usage();
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
	handlers tipo_apertura = 0;

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
				error_incorrect_parameters();
			}
		} else if (strcmp(argv[i], "-o") == 0 || strcmp(argv[i], "--output") == 0) {
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

	if (input == 0 && output == 0)
		tipo_apertura = STDIN_STDOUT;
	else if ((input == 1 && output == 0) || (input == 1 && strcmp(output_path, "-") == 0))
		tipo_apertura = ARCHIVO_STDOUT;
	else if ((input == 0 && output == 1) || (strcmp(input_path, "-") == 0 && output == 1))
		tipo_apertura = STDIN_ARCHIVO;
	else if (input == 1 && output == 1)
		tipo_apertura = ARCHIVO_ARCHIVO;
	else
		error_incorrect_parameters();

	switch (tipo_apertura) {
		case STDIN_STDOUT:
			printf("Utilizando \'stdin\' de entrada y \'stdout\' de salida...\n");
			input_handler = stdin;
			output_handler = stdout;
			break;
		case ARCHIVO_STDOUT:
			printf("Utilizando archivo \'%s\' de entrada y \'stdout\' de salida...\n", input_path);
			input_handler = fopen(input_path, "r");
			output_handler = stdout;
			if (!input_handler) {
				fprintf(stderr, "Error en apertura de archivo");
				return 1;
			}
			break;
		case STDIN_ARCHIVO:
			printf("Utilizando \'stdin\' de entrada y archivo \'%s\' de salida...\n", output_path);
			input_handler = stdin;
			output_handler = fopen(output_path, "w");
			if (!output_handler) {
				fprintf(stderr, "Error en apertura de archivo");
				return 1;
			}
			break;
		case ARCHIVO_ARCHIVO:
			printf("Utilizando archivo \'%s\' de entrada y archivo \'%s\' de salida...\n", input_path, output_path);
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

	switch (tipo_apertura) {
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
