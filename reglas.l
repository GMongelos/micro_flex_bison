/*** Definiciones ***/
%{
#include <stdio.h>
#include <string.h>
%}

/*** Reglas ***/
%%
inicio                  {printf("%s [INICIO]\n", yytext);}
fin                     {printf("%s [FIN]\n", yytext);}
leer                    {printf("%s [LEER]\n", yytext);}
escribir                {printf("%s [ESCRIBIR]\n", yytext);}
:=                      {printf("%s [ASIGNACION]\n", yytext);}
\(                      {printf("%s [PARENIZQUIERDO]\n", yytext);}
\)                      {printf("%s [PARENDERECHO]\n", yytext);}
,                       {printf("%s [COMA]\n", yytext);}
;                       {printf("%s [PUNTOYCOMA]\n", yytext);}
\+                      {printf("%s [SUMA]\n", yytext);}
-                       {printf("%s [RESTA]\n", yytext);}
[0-9]+                  {printf("%s [DIGITO]\n", yytext);}
[a-zA-Z][a-zA-Z0-9]*    {printf("%s [IDENTIFICADOR]\n", yytext);}
[ \t\n\r]+              /* Ignorar espacios en blanco */;
.                       {printf("%s [ERRORLEXICO]\n", yytext);}
%%

/*** Código ***/
int yywrap(){}
int main(int argc, char **argv){

    if (argc < 2) {
        printf("Uso: %s <nombre_archivo>\n", argv[0]);
        return 1;
    }

    char filename[100]; // taría bueno que sea dinamico

    strncpy(filename, argv[1], sizeof(filename) - 1);
    filename[sizeof(filename) - 1] = '\0';

    FILE *fp;

    fp = fopen(filename, "r");
    if (!fp) {
        perror("Error al abrir archivo");
        return 1;
    }

    yyin = fp;
    yylex();

    fclose(fp);
    return 0;
}