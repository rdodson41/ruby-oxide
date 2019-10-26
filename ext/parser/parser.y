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

  int yyerror(YYLTYPE *yylloc, yyscan_t scanner, Expression **expression, const char *message);
}

%code requires {
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
  | IDENTIFIER_TOKEN MAPPED_TO_TOKEN expression                 { $$ = create_function_expression($1, $3); }
  | expression LOGICAL_OR_TOKEN expression                      { $$ = create_or_expression($1, $3); }
  | expression LOGICAL_AND_TOKEN expression                     { $$ = create_and_expression($1, $3); }
  | expression EQUAL_TO_TOKEN expression                        { $$ = create_equal_expression($1, $3); }
  | expression NOT_EQUAL_TO_TOKEN expression                    { $$ = create_not_equal_expression($1, $3); }
  | expression '<' expression                                   { $$ = create_less_than_expression($1, $3); }
  | expression LESS_THAN_OR_EQUAL_TO_TOKEN expression           { $$ = create_less_than_or_equal_expression($1, $3); }
  | expression '>' expression                                   { $$ = create_greater_than_expression($1, $3); }
  | expression GREATER_THAN_OR_EQUAL_TO_TOKEN expression        { $$ = create_greater_than_or_equal_expression($1, $3); }
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

int yyerror(YYLTYPE *yylloc, yyscan_t scanner, Expression **expression, const char *message) {
  fprintf(stderr, "%i:%i: %s\n", yylloc->first_line, yylloc->first_column, message);
  return 0;
}

int parse_string(char *string, long length, Expression **expression) {
  yyscan_t scanner;

  if(yylex_init(&scanner) != 0) {
    perror("Could not initialize lexical analyzer");
    return 1;
  }

  YY_BUFFER_STATE buffer = yy_scan_bytes(string, length, scanner);

  int result = yyparse(scanner, expression);

  yy_delete_buffer(buffer, scanner);

  yylex_destroy(scanner);

  return result;
}

VALUE rb_fcall(VALUE self) {
  VALUE rb_vstring = rb_funcall(self, rb_intern("string"), 0);

  Expression *expression;

  if(parse_string(StringValuePtr(rb_vstring), RSTRING_LEN(rb_vstring), &expression) != 0)
    return Qnil;

  return expression_to_hash(expression);
}

void Init_parser() {
  VALUE rb_mOxide = rb_define_module("Oxide");
  VALUE rb_cStringParser = rb_define_class_under(rb_mOxide, "StringParser", rb_cObject);
  rb_define_method(rb_cStringParser, "call", rb_fcall, 0);
}
