%{

#include <stdnoreturn.h>

#include "parser.h"

#define YY_USER_ACTION \
  yylloc->first_line = yylineno; \
  yylloc->first_column = yycolumn; \
  yylloc->last_line = yylineno; \
  yylloc->last_column = yycolumn + (int)yyleng; \
  yycolumn += yyleng;

noreturn static void yy_fatal_error(yyconst char message[], yyscan_t scanner);

%}

%option bison-bridge
%option bison-locations
%option noinput
%option nounput
%option noyywrap
%option reentrant
%option yylineno

%%

[\t\n\r ]
[#].*
"let"                                                     { return LET_TOKEN; }
"var"                                                     { return VAR_TOKEN; }
"func"                                                    { return FUNC_TOKEN; }
"struct"                                                  { return STRUCT_TOKEN; }
"class"                                                   { return CLASS_TOKEN; }
"if"                                                      { return IF_TOKEN; }
"unless"                                                  { return UNLESS_TOKEN; }
"else"                                                    { return ELSE_TOKEN; }
"switch"                                                  { return SWITCH_TOKEN; }
"case"                                                    { return CASE_TOKEN; }
"default"                                                 { return DEFAULT_TOKEN; }
"while"                                                   { return WHILE_TOKEN; }
"until"                                                   { return UNTIL_TOKEN; }
"for"                                                     { return FOR_TOKEN; }
"end"                                                     { return END_TOKEN; }
"break"                                                   { return BREAK_TOKEN; }
"continue"                                                { return CONTINUE_TOKEN; }
"return"                                                  { return RETURN_TOKEN; }
"false"                                                   { return FALSE_TOKEN; }
"true"                                                    { return TRUE_TOKEN; }
"+="                                                      { return ADDITION_ASSIGNMENT_TOKEN; }
"-="                                                      { return SUBTRACTION_ASSIGNMENT_TOKEN; }
"*="                                                      { return MULTIPLICATION_ASSIGNMENT_TOKEN; }
"/="                                                      { return DIVISION_ASSIGNMENT_TOKEN; }
"%="                                                      { return MODULO_ASSIGNMENT_TOKEN; }
"||"                                                      { return LOGICAL_OR_TOKEN; }
"&&"                                                      { return LOGICAL_AND_TOKEN; }
"=="                                                      { return EQUAL_TO_TOKEN; }
"!="                                                      { return NOT_EQUAL_TO_TOKEN; }
"<="                                                      { return LESS_THAN_OR_EQUAL_TO_TOKEN; }
">="                                                      { return GREATER_THAN_OR_EQUAL_TO_TOKEN; }
"++"                                                      { return INCREMENT_TOKEN; }
"--"                                                      { return DECREMENT_TOKEN; }
[+-]?[0-9]+                                               { sscanf(yytext, "%li", &yylval->integer); return INTEGER_TOKEN; }
[+-]?0[Xx][0-9A-Fa-f]+                                    { sscanf(yytext, "%li", &yylval->integer); return INTEGER_TOKEN; }
[+-]?[0-9]+([.][0-9]+)?([Ee][+-]?[0-9]+)?                 { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT_TOKEN; }
[+-]?0[Xx][0-9A-Fa-f]+([.][0-9A-Fa-f]+)([Pp][+-]?[0-9]+)? { sscanf(yytext, "%lf", &yylval->floating_point); return FLOATING_POINT_TOKEN; }
[A-Za-z_][0-9A-Za-z_]*                                    { yylval->identifier = strndup(yytext, yyleng); return IDENTIFIER_TOKEN; }
.                                                         { return *yytext; }
