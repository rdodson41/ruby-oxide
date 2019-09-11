%{

#include "expression.h"
#include "expressions.h"
#include "parser.h"
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

%define api.pure full
%define parse.error verbose
%define parse.lac full

%parse-param { Expression **expression }

%%

input
  : expression                         { *expression = $1; }
  ;

expression
  : expression '|' expression          { $$ = create_pipe_expression($1, $3); }
  | expression '$' expression          { $$ = create_application_expression($1, $3); }
  | expression '+' expression          { $$ = create_addition_expression($1, $3); }
  | expression '-' expression          { $$ = create_subtraction_expression($1, $3); }
  | expression '*' expression          { $$ = create_multiplication_expression($1, $3); }
  | expression '/' expression          { $$ = create_division_expression($1, $3); }
  | '(' expression ')'                 { $$ = create_expression_expression($2); }
  | '{' expressions '}'                { $$ = create_expressions_expression($2); }
  | INTEGER                            { $$ = create_integer_expression($1); }
  | FLOATING_POINT                     { $$ = create_floating_point_expression($1); }
  | IDENTIFIER                         { $$ = create_identifier_expression($1); }
  | IDENTIFIER '=' expression          { $$ = create_assignment_expression($1, $3); }
  | IDENTIFIER IS_MAPPED_TO expression { $$ = create_function_expression($1, $3); }
  ;

expressions
  : expressions expression             { $$ = create_expressions_expressions($1, $2); }
  | expression                         { $$ = create_expression_expressions($1); }
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
