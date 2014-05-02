#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_COMMAND_SZ 256

int main( ) {
	char *comando = malloc (MAX_COMMAND_SZ);	
	printf("$ ");
	fgets (comando, MAX_COMMAND_SZ, stdin);
	/*Elimino enter */
	if ((strlen(comando)>0) && (comando[strlen (comando) - 1] == '\n'))
		comando[strlen (comando) - 1] = '\0';
	/*Busco pipe */
	char *segundaParte = strchr(comando, '|');
	if (segundaParte != NULL) {
		char *segundoComando;
		segundoComando=strndup(segundaParte+1, strlen (segundaParte)-1);
		printf("Segundo comando = [%s]\n", segundoComando);
	} else {
		printf("Primer comando [%s]\n",comando);
	}
	free (comando);
	return 0;
}
