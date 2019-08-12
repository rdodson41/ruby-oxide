%{

#include "block.h"
#include "expression.h"
#include "lexical_analyzer.h"

int yyerror(Expression **expression, const char *message);

%}

%union {
  int value;
  Expression *expression;
  Block *block;
}

%token <value> INTEGER

%left '+' '-'
%left '*' '/'

%type <expression> expression
%type <block> block

%start input

%parse-param { Expression **expression }

%%

input
  : expression                { *expression = $1; }
  ;

expression
  : expression '+' expression { $$ = create_addition_expression($1, $3); }
  | expression '-' expression { $$ = create_subtraction_expression($1, $3); }
  | expression '*' expression { $$ = create_multiplication_expression($1, $3); }
  | expression '/' expression { $$ = create_division_expression($1, $3); }
  | '{' block '}'             { $$ = create_block_expression($2); }
  | '(' expression ')'        { $$ = $2; }
  | INTEGER                   { $$ = create_literal_expression($1); }
  ;

block
  : block expression          { $$ = create_block($1, $2); }
  | expression                { $$ = create_block(NULL, $1); }
  ;

%%

int yyerror(Expression **expression, const char *message) {
  fprintf(stderr, "%s\n", message);
  return 0;
}

int main(const int argc, const char *argv[]) {
  Expression *expression;
  if(yyparse(&expression))
    return 1;
  print_expression(expression, 0);
}
