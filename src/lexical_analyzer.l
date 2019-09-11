%{

#include "expression.h"
#include "parser.h"

%}

%option bison-bridge
%option noyywrap
%option reentrant

%%

[\t\n\r ]
"->"                                                      { return IS_MAPPED_TO; }
[+-]?[0-9]+                                               { sscanf(yytext, "%li", &yylval->integer); return INTEGER; }
[+-]?0[Xx][0-9A-Fa-f]+                                    { sscanf(yytext, "%li", &yylval->integer); return INTEGER; }
[+-]?[0-9]+([.][0-9]+)?([Ee][+-]?[0-9]+)?                 { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT; }
[+-]?0[Xx][0-9A-Fa-f]+([.][0-9A-Fa-f]+)([Pp][+-]?[0-9]+)? { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT; }
[A-Za-z_][0-9A-Za-z_]*                                    { yylval->identifier = strndup(yytext, yyleng); return IDENTIFIER; }
.                                                         { return *yytext; }
