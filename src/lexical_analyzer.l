%{

#include "expression.h"
#include "parser.h"

%}

%option noyywrap

%%

[\t\n\r ]+
[0-9]+     { sscanf(yytext, "%i", &yylval.value); return INTEGER; }
.          { return *yytext; }
