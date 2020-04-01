%union {
  long integer;
  double floating_point;
  char *identifier;
  Expression *expression;
  Expressions *expressions;
}

%token                  FALSE_TOKEN
%token                  TRUE_TOKEN
%token <integer>        INTEGER_TOKEN
%token <floating_point> FLOATING_POINT_TOKEN
%token <identifier>     IDENTIFIER_TOKEN

%right '=' ADDITION_ASSIGNMENT_TOKEN SUBTRACTION_ASSIGNMENT_TOKEN MULTIPLICATION_ASSIGNMENT_TOKEN DIVISION_ASSIGNMENT_TOKEN MODULO_ASSIGNMENT_TOKEN MAPPED_TO_TOKEN
%left LOGICAL_OR_TOKEN
%left LOGICAL_AND_TOKEN
%left EQUAL_TO_TOKEN NOT_EQUAL_TO_TOKEN
%left '<' LESS_THAN_OR_EQUAL_TO_TOKEN '>' GREATER_THAN_OR_EQUAL_TO_TOKEN
%left '|'
%left '$'
%left '+' '-'
%left '*' '/' '%'

%nterm <expression> expression
%nterm <expressions> expressions

%start input

%code {
  #include "lexical_analyzer.h"

  void yyset_column(const int column, const yyscan_t scanner);
  void yyerror(const YYLTYPE *yylloc, const yyscan_t scanner, Expression **expression, const char *message);
}

%code requires {
  #include <ruby.h>

  #include "expression.h"
  #include "expressions.h"
}

%define api.pure full
%define parse.error verbose
%define parse.lac full

%locations

%param       { void *scanner }
%parse-param { Expression **expression }

%%

input
  : expression                                                  { *expression = $1; }
  ;

expression
  : FALSE_TOKEN                                                 { $$ = create_false_expression(); }
  | TRUE_TOKEN                                                  { $$ = create_true_expression(); }
  | INTEGER_TOKEN                                               { $$ = create_integer_expression($1); }
  | FLOATING_POINT_TOKEN                                        { $$ = create_floating_point_expression($1); }
  | IDENTIFIER_TOKEN                                            { $$ = create_identifier_expression($1); }
  | IDENTIFIER_TOKEN '=' expression                             { $$ = create_assignment_expression($1, $3); }
  | IDENTIFIER_TOKEN ADDITION_ASSIGNMENT_TOKEN expression       { $$ = create_addition_assignment_expression($1, $3); }
  | IDENTIFIER_TOKEN SUBTRACTION_ASSIGNMENT_TOKEN expression    { $$ = create_subtraction_assignment_expression($1, $3); }
  | IDENTIFIER_TOKEN MULTIPLICATION_ASSIGNMENT_TOKEN expression { $$ = create_multiplication_assignment_expression($1, $3); }
  | IDENTIFIER_TOKEN DIVISION_ASSIGNMENT_TOKEN expression       { $$ = create_division_assignment_expression($1, $3); }
  | IDENTIFIER_TOKEN MODULO_ASSIGNMENT_TOKEN expression         { $$ = create_modulo_assignment_expression($1, $3); }
  | IDENTIFIER_TOKEN MAPPED_TO_TOKEN expression                 { $$ = create_mapped_to_expression($1, $3); }
  | expression LOGICAL_OR_TOKEN expression                      { $$ = create_logical_or_expression($1, $3); }
  | expression LOGICAL_AND_TOKEN expression                     { $$ = create_logical_and_expression($1, $3); }
  | expression EQUAL_TO_TOKEN expression                        { $$ = create_equal_to_expression($1, $3); }
  | expression NOT_EQUAL_TO_TOKEN expression                    { $$ = create_not_equal_to_expression($1, $3); }
  | expression '<' expression                                   { $$ = create_less_than_expression($1, $3); }
  | expression LESS_THAN_OR_EQUAL_TO_TOKEN expression           { $$ = create_less_than_or_equal_to_expression($1, $3); }
  | expression '>' expression                                   { $$ = create_greater_than_expression($1, $3); }
  | expression GREATER_THAN_OR_EQUAL_TO_TOKEN expression        { $$ = create_greater_than_or_equal_to_expression($1, $3); }
  | expression '|' expression                                   { $$ = create_pipe_expression($1, $3); }
  | expression '$' expression                                   { $$ = create_application_expression($1, $3); }
  | expression '+' expression                                   { $$ = create_addition_expression($1, $3); }
  | expression '-' expression                                   { $$ = create_subtraction_expression($1, $3); }
  | expression '*' expression                                   { $$ = create_multiplication_expression($1, $3); }
  | expression '/' expression                                   { $$ = create_division_expression($1, $3); }
  | expression '%' expression                                   { $$ = create_modulo_expression($1, $3); }
  | '(' expression ')'                                          { $$ = create_expression_expression($2); }
  | '{' expressions '}'                                         { $$ = create_expressions_expression($2); }
  ;

expressions
  : expression                                                  { $$ = create_expression_expressions($1); }
  | expressions expression                                      { $$ = create_expressions($1, $2); }
  ;

%%

void yyerror(const YYLTYPE *yylloc, const yyscan_t scanner, Expression **expression, const char *message) {
  fprintf(stderr, "%i:%i: %s\n", yylloc->first_line, yylloc->first_column, message);
}

static void deallocate_parser(yyscan_t scanner) {
  yylex_destroy(scanner);
}

static VALUE allocate_parser(const VALUE cParser) {
  yyscan_t scanner;

  if(yylex_init(&scanner) != 0)
    rb_raise(rb_eRuntimeError, "%s", strerror(errno));

  return Data_Wrap_Struct(cParser, NULL, deallocate_parser, scanner);
}

static VALUE call_parser(const VALUE parser) {
  yyscan_t scanner;

  Data_Get_Struct(parser, yyscan_t, scanner);

  Expression *expression;

  if(yyparse(scanner, &expression) != 0)
    rb_raise(rb_eRuntimeError, "Could not parse input");

  const VALUE syntax_tree = expression_to_hash(expression);

  delete_expression(expression);

  return syntax_tree;
}

static VALUE initialize_string_parser(const VALUE string_parser, VALUE input) {
  yyscan_t scanner;

  Data_Get_Struct(string_parser, yyscan_t, scanner);

  yy_scan_bytes(StringValuePtr(input), RSTRING_LEN(input), scanner);

  yyset_lineno(1, scanner);
  yyset_column(1, scanner);

  return Qnil;
}

void Init_parser() {
  const VALUE mOxide = rb_define_module("Oxide");
  const VALUE cParser = rb_define_class_under(mOxide, "Parser", rb_cObject);
  const VALUE cStringParser = rb_define_class_under(mOxide, "StringParser", cParser);

  rb_define_alloc_func(cParser, allocate_parser);
  rb_define_method(cParser, "call", call_parser, 0);
  rb_define_method(cStringParser, "initialize", initialize_string_parser, 1);
}
