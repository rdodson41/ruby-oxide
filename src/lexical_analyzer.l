%{

#include "expression.h"
#include "parser.h"

%}

%option noyywrap

%%

[\t\n\r ]
"->"      { return IS_MAPPED_TO; }
[0-9]+    { sscanf(yytext, "%u", &yylval.literal); return LITERAL; }
[a-z]+    { yylval.identifier = strndup(yytext, yyleng); return IDENTIFIER; }
.         { return *yytext; }
