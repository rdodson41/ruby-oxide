%{

#include "expression.h"
#include "parser.h"

#define YY_USER_ACTION \
  yylloc->first_line = yylineno; \
  yylloc->first_column = yycolumn; \
  yylloc->last_line = yylineno; \
  yylloc->last_column = yycolumn + yyleng; \
  yycolumn += yyleng;

%}

%option bison-bridge
%option bison-locations
%option noinput
%option nounput
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
"||"                                                      { return OR; }
"&&"                                                      { return AND; }
"=="                                                      { return IS_EQUAL_TO; }
"!="                                                      { return IS_NOT_EQUAL_TO; }
"<="                                                      { return IS_LESS_THAN_OR_EQUAL_TO; }
">="                                                      { return IS_GREATER_THAN_OR_EQUAL_TO; }
"false"                                                   { return FALSE; }
"true"                                                    { return TRUE; }
[+-]?[0-9]+                                               { sscanf(yytext, "%li", &yylval->integer); return INTEGER; }
[+-]?0[Xx][0-9A-Fa-f]+                                    { sscanf(yytext, "%li", &yylval->integer); return INTEGER; }
[+-]?[0-9]+([.][0-9]+)?([Ee][+-]?[0-9]+)?                 { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT; }
[+-]?0[Xx][0-9A-Fa-f]+([.][0-9A-Fa-f]+)([Pp][+-]?[0-9]+)? { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT; }
[A-Za-z_][0-9A-Za-z_]*                                    { yylval->identifier = strndup(yytext, yyleng); return IDENTIFIER; }
.                                                         { return *yytext; }
