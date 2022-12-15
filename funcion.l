%option noyywrap
%{
    #include "funcion.tab.h"    
%}

%% 
"function"                  { strcpy(yylval.cadena,yytext); return PALFUNCION; }
"integer"                   { strcpy(yylval.cadena,yytext); return PALINTEGER; }
"real"                      { strcpy(yylval.cadena,yytext); return PALREAL; }
"var"                       { strcpy(yylval.cadena,yytext); return PALVAR; }
"begin"                     { strcpy(yylval.cadena,yytext); return PALBEGIN; }
"end"                       { strcpy(yylval.cadena,yytext); return PALEND; }
"("                         { strcpy(yylval.cadena,yytext); return PI; }
")"                         { strcpy(yylval.cadena,yytext); return PF; }
","                         { strcpy(yylval.cadena,yytext); return COMA;}
":="                        { strcpy(yylval.cadena,yytext); return PASCALIGUAL;        }
":"                         { strcpy(yylval.cadena,yytext); return DOSPUNTOS; }
";"                         { strcpy(yylval.cadena,yytext); return PUNTOYCOMA; }
"+"                         { strcpy(yylval.cadena,yytext); return SIGNOMAS;        }
"-"                         { strcpy(yylval.cadena,yytext); return SIGNOMENOS;      }
"*"                         { strcpy(yylval.cadena,yytext); return SIGNOMULT;       }
"/"                         { strcpy(yylval.cadena,yytext); return SIGNODIV;        }
" "+                        { strcpy(yylval.cadena,yytext); return UNOOMASESP;      }
[a-zA-Z"_"]([a-zA-Z]|[0-9]|"_")*   { strcpy(yylval.cadena,yytext); return IDENTIFICADOR;   }
[0-9]+                      { strcpy(yylval.cadena,yytext); return NUMENTERO;          }
[0-9]+"."[0-9]+             { strcpy(yylval.cadena,yytext); return NUMREAL;          }
\n+                          { strcpy(yylval.cadena,yytext); return EOL;             }
.                           {  }

%%
