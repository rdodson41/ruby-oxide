%{

#include "expression.h"
#include "parser.h"

#define YY_USER_ACTION \
    yylloc->first_line = yylineno; \
    yylloc->last_line = yylloc->first_line; \
    yylloc->first_column = yycolumn; \
    yylloc->last_column = yylloc->first_column + yyleng; \
    strncpy(&line[yylloc->first_column], yytext, yyleng); \
    line[yylloc->last_column] = '\0'; \
    yycolumn += yyleng;

char line[256];

%}

%option bison-bridge
%option bison-locations
%option noyywrap
%option reentrant
%option yylineno

%%

[\t\r ]
[\n]                                                      { yycolumn = 0; }
[#].*
"+="                                                      { return EQUALS_ADDED_TO; }
"-="                                                      { return EQUALS_SUBTRACTED_FROM; }
"*="                                                      { return EQUALS_MULTIPLIED_BY; }
"/="                                                      { return EQUALS_DIVIDED_BY; }
"%="                                                      { return EQUALS_MODULO; }
"->"                                                      { return IS_MAPPED_TO; }
[+-]?[0-9]+                                               { sscanf(yytext, "%li", &yylval->integer); return INTEGER; }
[+-]?0[Xx][0-9A-Fa-f]+                                    { sscanf(yytext, "%li", &yylval->integer); return INTEGER; }
[+-]?[0-9]+([.][0-9]+)?([Ee][+-]?[0-9]+)?                 { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT; }
[+-]?0[Xx][0-9A-Fa-f]+([.][0-9A-Fa-f]+)([Pp][+-]?[0-9]+)? { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT; }
[A-Za-z_][0-9A-Za-z_]*                                    { yylval->identifier = strndup(yytext, yyleng); return IDENTIFIER; }
.                                                         { return *yytext; }
