%{

#include "parser.h"

%}

%option noyywrap

%%

[\t\n\r ]+
[0-9]+     { return INTEGER; }
.          { return *yytext; }
