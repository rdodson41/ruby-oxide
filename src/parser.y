%{

#include "lexical_analyzer.h"

int yyerror(const char *message);

%}

%left '+' '-'
%left '*' '/'

%token INTEGER

%%

expressions
  : expression expressions
  |
  ;

expression
  : expression '+' expression
  | expression '-' expression
  | expression '*' expression
  | expression '/' expression
  | '(' expression ')'
  | INTEGER
  ;

%%

int yyerror(const char *message) {
  fprintf(stderr, "%s\n", message);
  return 0;
}

int main(const int argc, const char *argv[]) {
  yyparse();
}
