%{

#include <ruby.h>

#include "expression.h"
#include "expressions.h"
#include "parser.h"
#include "lexical_analyzer.h"

int yyerror(YYLTYPE *yylloc, yyscan_t scanner, Expression **expression, const char *message);

%}

%union {
  long integer;
  double floating_point;
  char *identifier;
  Expression *expression;
  Expressions *expressions;
}

%token                  EQUALS_ADDED_TO
%token                  EQUALS_SUBTRACTED_FROM
%token                  EQUALS_MULTIPLIED_BY
%token                  EQUALS_DIVIDED_BY
%token                  EQUALS_MODULO
%token                  IS_MAPPED_TO
%token                  OR
%token                  AND
%token                  IS_EQUAL_TO
%token                  IS_NOT_EQUAL_TO
%token                  IS_LESS_THAN_OR_EQUAL_TO
%token                  IS_GREATER_THAN_OR_EQUAL_TO
%token                  FALSE
%token                  TRUE
%token <integer>        INTEGER
%token <floating_point> FLOATING_POINT
%token <identifier>     IDENTIFIER

%right '=' EQUALS_ADDED_TO EQUALS_SUBTRACTED_FROM EQUALS_MULTIPLIED_BY EQUALS_DIVIDED_BY EQUALS_MODULO
%right IS_MAPPED_TO
%left OR
%left AND
%left IS_EQUAL_TO IS_NOT_EQUAL_TO
%left '<' IS_LESS_THAN_OR_EQUAL_TO '>' IS_GREATER_THAN_OR_EQUAL_TO
%left '|'
%left '$'
%left '+' '-'
%left '*' '/' '%'

%type <expression> expression
%type <expressions> expressions

%start input

%define api.pure full
%define parse.error verbose
%define parse.lac full

%locations

%param       { void *scanner }
%parse-param { Expression **expression }

%%

input
  : expression                                        { *expression = $1; }
  ;

expression
  : expression OR expression                          { $$ = create_or_expression($1, $3); }
  | expression AND expression                         { $$ = create_and_expression($1, $3); }
  | expression IS_EQUAL_TO expression                 { $$ = create_equal_expression($1, $3); }
  | expression IS_NOT_EQUAL_TO expression             { $$ = create_not_equal_expression($1, $3); }
  | expression '<' expression                         { $$ = create_less_than_expression($1, $3); }
  | expression IS_LESS_THAN_OR_EQUAL_TO expression    { $$ = create_less_than_or_equal_expression($1, $3); }
  | expression '>' expression                         { $$ = create_greater_than_expression($1, $3); }
  | expression IS_GREATER_THAN_OR_EQUAL_TO expression { $$ = create_greater_than_or_equal_expression($1, $3); }
  | expression '|' expression                         { $$ = create_pipe_expression($1, $3); }
  | expression '$' expression                         { $$ = create_application_expression($1, $3); }
  | expression '+' expression                         { $$ = create_addition_expression($1, $3); }
  | expression '-' expression                         { $$ = create_subtraction_expression($1, $3); }
  | expression '*' expression                         { $$ = create_multiplication_expression($1, $3); }
  | expression '/' expression                         { $$ = create_division_expression($1, $3); }
  | expression '%' expression                         { $$ = create_modulo_expression($1, $3); }
  | '(' expression ')'                                { $$ = create_expression_expression($2); }
  | '{' expressions '}'                               { $$ = create_expressions_expression($2); }
  | FALSE                                             { $$ = create_false_expression(); }
  | TRUE                                              { $$ = create_true_expression(); }
  | INTEGER                                           { $$ = create_integer_expression($1); }
  | FLOATING_POINT                                    { $$ = create_floating_point_expression($1); }
  | IDENTIFIER                                        { $$ = create_identifier_expression($1); }
  | IDENTIFIER '=' expression                         { $$ = create_assignment_expression($1, $3); }
  | IDENTIFIER EQUALS_ADDED_TO expression             { $$ = create_addition_assignment_expression($1, $3); }
  | IDENTIFIER EQUALS_SUBTRACTED_FROM expression      { $$ = create_subtraction_assignment_expression($1, $3); }
  | IDENTIFIER EQUALS_MULTIPLIED_BY expression        { $$ = create_multiplication_assignment_expression($1, $3); }
  | IDENTIFIER EQUALS_DIVIDED_BY expression           { $$ = create_division_assignment_expression($1, $3); }
  | IDENTIFIER EQUALS_MODULO expression               { $$ = create_modulo_assignment_expression($1, $3); }
  | IDENTIFIER IS_MAPPED_TO expression                { $$ = create_function_expression($1, $3); }
  ;

expressions
  : expressions expression                            { $$ = create_expressions_expressions($1, $2); }
  | expression                                        { $$ = create_expression_expressions($1); }
  ;

%%

int yyerror(YYLTYPE *yylloc, yyscan_t scanner, Expression **expression, const char *message) {
  fprintf(stderr, "%i:%i: %s\n", yylloc->first_line, yylloc->first_column, message);
  return 0;
}

VALUE call(VALUE self) {
  yyscan_t scanner;

  if(yylex_init(&scanner) != 0) {
    perror("Could not initialize lexical analyzer");
    return Qnil;
  }

  while(1) {
    char *line = NULL;
    size_t linecap = 0;
    ssize_t linelen = getline(&line, &linecap, stdin);

    if(linelen < 1)
      break;

    YY_BUFFER_STATE buffer = yy_scan_string(line, scanner);

    Expression *expression;

    int result = yyparse(scanner, &expression);

    yy_delete_buffer(buffer, scanner);

    if(result != 0)
      break;

    print_expression(expression, 0, 0);
  }

  yylex_destroy(scanner);

  return Qnil;
}

void Init_parser() {
  VALUE oxide = rb_define_module("Oxide");
  VALUE parser = rb_define_module_under(oxide, "Parser");
  rb_define_singleton_method(parser, "call", call, 0);
}
