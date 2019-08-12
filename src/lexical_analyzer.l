%{

#include "expression.h"
#include "parser.h"

%}

%option noyywrap

%%

[\t\r ]+
[0-9]+     { sscanf(yytext, "%i", &yylval.value); return INTEGER; }
[\n]       { return *yytext; }
.          { return *yytext; }
