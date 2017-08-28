#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define VERSION "0.0.3"

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

int es_capicua(char* palabra)
{
	size_t izq = 0, longitud;
	longitud = strlen(palabra);

	if (longitud == 0)
		return 0;

	for (izq = 0; izq < longitud/2; izq++) {
		int der = longitud - izq -1;
		if (tolower(palabra[izq]) != tolower(palabra[der]))
			return 0;
	}
	return 1;
}

int caracter_valido(char caracter)
{
	char minuscula = tolower(caracter);
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

int procesar_archivo(char* input_path, char* output_path)
{	/*Abre el archivo que se va a leer con las palabras capicuas*/
	FILE* archivo_entrada = fopen(input_path, "r");
	/*Abre el archivo sobre el que se va a escribir la salida */
	FILE* archivo_salida = fopen(output_path, "w");
	char* linea;
	char* linea_valida;

	if (!archivo_entrada || !archivo_salida) {
		if (!archivo_entrada) fclose(archivo_entrada);
		if (!archivo_salida)  fclose(archivo_salida);
		return 0;
	}

	while (fgets2(&linea, archivo_entrada))	{
		quitar_caracteres_invalidos(linea, &linea_valida);
		char* palabra = strtok(linea_valida, " ");
		while (palabra) {
			if (es_capicua(palabra))
				fprintf(archivo_salida, "%s ", palabra);
			palabra = strtok(NULL, " ");
		}
        	free(linea);
        	free(linea_valida);
    	}

	fclose(archivo_entrada);
	fclose(archivo_salida);
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

	if (input == 0 && output == 0) {
		printf("Utilizando \'stdin\' de entrada y \'stdout\' de salida...\n");
	} else if ((input == 1 && output == 0) || (input == 1 && strcmp(output_path, "-") == 0)) {
		printf("Utilizando archivo \'%s\' de entrada y \'stdout\' de salida...\n", input_path);
	} else if ((input == 0 && output == 1) || (strcmp(input_path, "-") == 0 && output == 1)) {
		printf("Utilizando \'stdin\' de entrada y archivo \'%s\' de salida...\n", output_path);
	} else if (input == 1 && output == 1) {
		printf("Utilizando archivo \'%s\' de entrada y archivo \'%s\' de salida...\n", input_path, output_path);
		procesar_archivo(input_path, output_path);
	} else {
		error_incorrect_parameters();
	}

	return 0;
}
