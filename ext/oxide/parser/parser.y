%union {
  long integer;
  double floating_point;
  char *identifier;
  VALUE expression;
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

%start input

%code {
  #include "lexical_analyzer.h"

  void yyset_column(const int column, const yyscan_t scanner);
  void yyerror(const YYLTYPE *yylloc, const yyscan_t scanner, VALUE *expression, const char *message);
}

%code requires {
  #include <ruby.h>
}

%define api.pure full
%define parse.error verbose
%define parse.lac full

%locations

%param       { void *scanner }
%parse-param { VALUE *expression }

%%

input
  : expression                                                  { *expression = $1; }
  ;

expression
  : FALSE_TOKEN                                                 { $$ = rb_funcall(rb_path2class("Oxide::Expressions::False"), rb_intern("new"), 0); }
  | TRUE_TOKEN                                                  { $$ = rb_funcall(rb_path2class("Oxide::Expressions::True"), rb_intern("new"), 0); }
  | INTEGER_TOKEN                                               { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Integer"), rb_intern("new"), 1, INT2NUM($1)); }
  | FLOATING_POINT_TOKEN                                        { $$ = rb_funcall(rb_path2class("Oxide::Expressions::FloatingPoint"),rb_intern("new"), 1, rb_float_new($1)); }
  | IDENTIFIER_TOKEN                                            { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Identifier"), rb_intern("new"), 1, rb_str_new2($1)); }
  | IDENTIFIER_TOKEN '=' expression                             { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Assignment"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | IDENTIFIER_TOKEN ADDITION_ASSIGNMENT_TOKEN expression       { $$ = rb_funcall(rb_path2class("Oxide::Expressions::AdditionAssignment"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | IDENTIFIER_TOKEN SUBTRACTION_ASSIGNMENT_TOKEN expression    { $$ = rb_funcall(rb_path2class("Oxide::Expressions::SubtractionAssignment"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | IDENTIFIER_TOKEN MULTIPLICATION_ASSIGNMENT_TOKEN expression { $$ = rb_funcall(rb_path2class("Oxide::Expressions::MultiplicationAssignment"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | IDENTIFIER_TOKEN DIVISION_ASSIGNMENT_TOKEN expression       { $$ = rb_funcall(rb_path2class("Oxide::Expressions::DivisionAssignment"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | IDENTIFIER_TOKEN MODULO_ASSIGNMENT_TOKEN expression         { $$ = rb_funcall(rb_path2class("Oxide::Expressions::ModuloAssignment"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | IDENTIFIER_TOKEN MAPPED_TO_TOKEN expression                 { $$ = rb_funcall(rb_path2class("Oxide::Expressions::MappedTo"), rb_intern("new"), 2, rb_str_new2($1), $3); }
  | expression LOGICAL_OR_TOKEN expression                      { $$ = rb_funcall(rb_path2class("Oxide::Expressions::LogicalOr"), rb_intern("new"), 2, $1, $3); }
  | expression LOGICAL_AND_TOKEN expression                     { $$ = rb_funcall(rb_path2class("Oxide::Expressions::LogicalAnd"), rb_intern("new"), 2, $1, $3); }
  | expression EQUAL_TO_TOKEN expression                        { $$ = rb_funcall(rb_path2class("Oxide::Expressions::EqualTo"), rb_intern("new"), 2, $1, $3); }
  | expression NOT_EQUAL_TO_TOKEN expression                    { $$ = rb_funcall(rb_path2class("Oxide::Expressions::NotEqualTo"), rb_intern("new"), 2, $1, $3); }
  | expression '<' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::LessThan"), rb_intern("new"), 2, $1, $3); }
  | expression LESS_THAN_OR_EQUAL_TO_TOKEN expression           { $$ = rb_funcall(rb_path2class("Oxide::Expressions::LessThanOrEqualTo"), rb_intern("new"), 2, $1, $3); }
  | expression '>' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::GreaterThan"), rb_intern("new"), 2, $1, $3); }
  | expression GREATER_THAN_OR_EQUAL_TO_TOKEN expression        { $$ = rb_funcall(rb_path2class("Oxide::Expressions::GreaterThanOrEqualTo"), rb_intern("new"), 2, $1, $3); }
  | expression '|' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Pipe"), rb_intern("new"), 2, $1, $3); }
  | expression '$' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Application"), rb_intern("new"), 2, $1, $3); }
  | expression '+' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Addition"), rb_intern("new"), 2, $1, $3); }
  | expression '-' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Subtraction"), rb_intern("new"), 2, $1, $3); }
  | expression '*' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Multiplication"), rb_intern("new"), 2, $1, $3); }
  | expression '/' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Division"), rb_intern("new"), 2, $1, $3); }
  | expression '%' expression                                   { $$ = rb_funcall(rb_path2class("Oxide::Expressions::Modulo"), rb_intern("new"), 2, $1, $3); }
  | '(' expression ')'                                          { $$ = $2; }
  ;

%%

void yyerror(const YYLTYPE *yylloc, const yyscan_t scanner, VALUE *expression, const char *message) {
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

  VALUE expression;

  if(yyparse(scanner, &expression) != 0)
    rb_raise(rb_eRuntimeError, "Could not parse input");

  return expression;
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
