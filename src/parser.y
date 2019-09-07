%{

#include "expression.h"
#include "expressions.h"
#include "lexical_analyzer.h"

int yyerror(Expression **expression, const char *message);

%}

%union {
  long integer;
  double floating_point;
  char *identifier;
  Expression *expression;
  Expressions *expressions;
}

%token                  IS_MAPPED_TO
%token <integer>        INTEGER
%token <floating_point> FLOATING_POINT
%token <identifier>     IDENTIFIER

%left '|'
%left '$'
%right '='
%right IS_MAPPED_TO
%left '+' '-'
%left '*' '/'

%type <expression> expression
%type <expressions> expressions

%start input

%parse-param { Expression **expression }

%%

input
  : expression                         { *expression = $1; }
  ;

expression
  : expression '|' expression          { $$ = create_expression(PIPE_EXPRESSION, $1, $3, NULL, 0, 0, NULL); }
  | expression '$' expression          { $$ = create_expression(APPLICATION_EXPRESSION, $1, $3, NULL, 0, 0, NULL); }
  | expression '+' expression          { $$ = create_expression(ADDITION_EXPRESSION, $1, $3, NULL, 0, 0, NULL); }
  | expression '-' expression          { $$ = create_expression(SUBTRACTION_EXPRESSION, $1, $3, NULL, 0, 0, NULL); }
  | expression '*' expression          { $$ = create_expression(MULTIPLICATION_EXPRESSION, $1, $3, NULL, 0, 0, NULL); }
  | expression '/' expression          { $$ = create_expression(DIVISION_EXPRESSION, $1, $3, NULL, 0, 0, NULL); }
  | '(' expression ')'                 { $$ = $2; }
  | '{' expressions '}'                { $$ = create_expression(EXPRESSIONS_EXPRESSION, NULL, NULL, $2, 0, 0, NULL); }
  | INTEGER                            { $$ = create_expression(INTEGER_EXPRESSION, NULL, NULL, NULL, $1, 0, NULL); }
  | FLOATING_POINT                     { $$ = create_expression(FLOATING_POINT_EXPRESSION, NULL, NULL, NULL, 0, $1, NULL); }
  | IDENTIFIER                         { $$ = create_expression(IDENTIFIER_EXPRESSION, NULL, NULL, NULL, 0, 0, $1); }
  | IDENTIFIER '=' expression          { $$ = create_expression(ASSIGNMENT_EXPRESSION, NULL, $3, NULL, 0, 0, $1); }
  | IDENTIFIER IS_MAPPED_TO expression { $$ = create_expression(FUNCTION_EXPRESSION, NULL, $3, NULL, 0, 0, $1); }
  ;

expressions
  : expressions expression             { $$ = create_expressions($1, $2); }
  | expression                         { $$ = create_expressions(NULL, $1); }
  ;

%%

int yyerror(Expression **expression, const char *message) {
  fprintf(stderr, "%s\n", message);
  return 0;
}

int main(const int argc, const char *argv[]) {
  Expression *expression;
  if(!yyparse(&expression))
    print_expression(expression, 0, 0);
  return 0;
}
