%{

#include "expression.h"
#include "lexical_analyzer.h"

int yyerror(const char *message);

%}

%union {
  Expression *expression;
  int value;
}

%type <expression> expression

%token <value> INTEGER

%left '+' '-'
%left '*' '/'

%%

statements
  : statements statement '\n'
  |
  ;

statement
  : expression                { printf("=> %i\n", evaluate_expression($1)); }
  |
  ;

expression
  : expression '+' expression { $$ = create_addition($1, $3); }
  | expression '-' expression { $$ = create_subtraction($1, $3); }
  | expression '*' expression { $$ = create_multiplication($1, $3); }
  | expression '/' expression { $$ = create_division($1, $3); }
  | '(' expression ')'        { $$ = $2; }
  | INTEGER                   { $$ = create_literal($1); }
  ;

%%

int yyerror(const char *message) {
  fprintf(stderr, "%s\n", message);
  return 0;
}

int main(const int argc, const char *argv[]) {
  yyparse();
}
