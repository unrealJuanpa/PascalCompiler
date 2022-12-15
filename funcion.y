%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <conio.h>

    int actual = 1;
    char nfun[500] = "";
    char simbolos[1000] = "";
    char tmpyo[1000] = "";

    void yyerror(char *mensaje);
    void nuevaTemp(char *s);
    int yylex();

    void myfuncion(char *p1, char *var){
        if (strcmp(p1, nfun) == 0) { 
            printf("\tpush %s;",var); 
        }
    }

    void myfuncion2(char *p1){
        if (strcmp(p1, nfun) == 0) { 
            
        }
        else {
            printf("\t%s=#%s%i;\n", p1, "t", actual-1);
        }
    }
%}

%union{
    char cadena[50];
}



%token <cadena>PALFUNCION
%token <cadena>PALINTEGER
%token <cadena>PALREAL
%token <cadena>PALVAR
%token <cadena>PALBEGIN
%token <cadena>PALEND
%token <cadena>PASCALIGUAL
%token <cadena>DOSPUNTOS
%token <cadena>PUNTOYCOMA
%token <cadena>SIGNOMAS
%token <cadena>SIGNOMENOS
%token <cadena>SIGNOMULT
%token <cadena>SIGNODIV
%token <cadena>UNOOMASESP
%token <cadena>IDENTIFICADOR
%token <cadena>NUMENTERO
%token <cadena>NUMREAL
%token <cadena>PI
%token <cadena>PF
%token <cadena>EOL
%token <cadena>COMA

%type <cadena> operacion
%type <cadena> identifoint

%%
inicio      : funcion           { printf("\n\nSintaxis correcta!\n"); return 0; }
            ;

ceromesp    : UNOOMASESP
            |
            ; 


tipodato    : PALINTEGER
            | PALREAL
            ;

decvar1     : IDENTIFICADOR ceromesp DOSPUNTOS ceromesp tipodato { printf("\tpop %s;\n", $1); strcpy(tmpyo, ""); sprintf(tmpyo, "%s | variable | local\n", $1); strcat(simbolos, tmpyo); }
            ;

decvar1concat   : ceromesp COMA ceromesp decvar1 decvar1concat
                |
                ;

decvar1func     : decvar1 decvar1concat
                ;

unoomaseol      : EOL unoomaseol
                |
                ;

decvarotro  : IDENTIFICADOR ceromesp DOSPUNTOS ceromesp tipodato { strcpy(tmpyo, ""); sprintf(tmpyo, "%s | variable | local\n", $1); strcat(simbolos, tmpyo); }
            ;

decvar2         : decvarotro PUNTOYCOMA
                | IDENTIFICADOR ceromesp decvartipoconcat ceromesp DOSPUNTOS ceromesp tipodato ceromesp PUNTOYCOMA
                ;

decvartipoconcat    : COMA ceromesp IDENTIFICADOR ceromesp decvartipoconcat
                    |
                    ;

decvarconcatfinal   : ceromesp decvar2 decvarconcatfinal unoomaseol
                    |
                    ;

decvarinterno   : PALVAR ceromesp unoomaseol ceromesp decvar2 unoomaseol decvarconcatfinal
                | 
                ;

identifoint     : IDENTIFICADOR { strcpy($$, $1); }
                | NUMENTERO { strcpy($$, $1); }
                | NUMREAL { strcpy($$, $1); }
                ;

operacion   : operacion ceromesp SIGNOMAS ceromesp identifoint { nuevaTemp($$); printf("\t%s=%s+%s;\n",$$,$1,$5); }
            | operacion ceromesp SIGNOMENOS ceromesp identifoint { nuevaTemp($$); printf("\t%s=%s-%s;\n",$$,$1,$5);  }
            | operacion ceromesp SIGNOMULT ceromesp identifoint { nuevaTemp($$); printf("\t%s=%s*%s;\n",$$,$1,$5);  }
            | operacion ceromesp SIGNODIV ceromesp identifoint { nuevaTemp($$); printf("\t%s=%s/%s;\n",$$,$1,$5);  }
            | identifoint                                           {  }
            ; 

asignacion  : IDENTIFICADOR ceromesp PASCALIGUAL ceromesp operacion PUNTOYCOMA  { myfuncion2($1); myfuncion($1, $5); }
            ; 

concatopline    : ceromesp asignacion unoomaseol concatopline
                |
                ;

iniciopalfun    : IDENTIFICADOR { printf("%s:\n", $1); strcpy(nfun, $1); strcpy(tmpyo, ""); sprintf(tmpyo, "%s | funcion | global\n", $1); strcat(simbolos, tmpyo); }
                ;

funcion     : unoomaseol PALFUNCION UNOOMASESP iniciopalfun ceromesp PI decvar1func PF ceromesp DOSPUNTOS ceromesp tipodato ceromesp PUNTOYCOMA unoomaseol decvarinterno PALBEGIN unoomaseol concatopline PALEND unoomaseol
            ;
%%

void nuevaTemp(char *s) {
    sprintf(s, "#t%d", actual++);
} 

void yyerror(char *mensaje) {
    system("clear"); 
    fprintf(stderr, "Error de sintaxis\n");
}

int main() {
    yyparse();

    printf("\n\n----- Tabla de simbolos -----\n");
    printf("Simbolo | Tipo | Ambito\n");
    printf(simbolos);

    return 0;
}
