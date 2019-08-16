%{

#include "expression.h"
#include "lexical_analyzer.h"

int yyerror(Expression **expression, const char *message);

%}

%union {
  int literal;
  char *identifier;
  Expression *expression;
}

%token              IS_MAPPED_TO
%token <literal>    LITERAL
%token <identifier> IDENTIFIER

%left '|'
%left '$'
%right IS_MAPPED_TO
%left '+' '-'
%left '*' '/'

%type <expression> expression

%start input

%parse-param { Expression **expression }

%%

input
  : expression                         { *expression = $1; }
  ;

expression
  : expression '|' expression          { $$ = create_expression(PIPE_EXPRESSION, $1, $3, 0, NULL); }
  | expression '$' expression          { $$ = create_expression(APPLICATION_EXPRESSION, $1, $3, 0, NULL); }
  | expression '+' expression          { $$ = create_expression(ADDITION_EXPRESSION, $1, $3, 0, NULL); }
  | expression '-' expression          { $$ = create_expression(SUBTRACTION_EXPRESSION, $1, $3, 0, NULL); }
  | expression '*' expression          { $$ = create_expression(MULTIPLICATION_EXPRESSION, $1, $3, 0, NULL); }
  | expression '/' expression          { $$ = create_expression(DIVISION_EXPRESSION, $1, $3, 0, NULL); }
  | '(' expression ')'                 { $$ = $2; }
  | LITERAL                            { $$ = create_expression(LITERAL_EXPRESSION, NULL, NULL, $1, NULL); }
  | IDENTIFIER                         { $$ = create_expression(IDENTIFIER_EXPRESSION, NULL, NULL, 0, $1); }
  | IDENTIFIER IS_MAPPED_TO expression { $$ = create_expression(FUNCTION_EXPRESSION, NULL, $3, 0, $1); }
  ;

%%

int yyerror(Expression **expression, const char *message) {
  fprintf(stderr, "%s\n", message);
  return 0;
}

int main(const int argc, const char *argv[]) {
  Expression *expression;
  if(!yyparse(&expression))
    print_expression(expression, 0);
  return 0;
}
