%union {
  long integer;
  double floating_point;
  char *identifier;
  VALUE expression;
}

%token                  LET_TOKEN
%token                  VAR_TOKEN
%token                  FUNC_TOKEN
%token                  STRUCT_TOKEN
%token                  CLASS_TOKEN
%token                  IF_TOKEN
%token                  UNLESS_TOKEN
%token                  ELSE_TOKEN
%token                  SWITCH_TOKEN
%token                  CASE_TOKEN
%token                  DEFAULT_TOKEN
%token                  WHILE_TOKEN
%token                  UNTIL_TOKEN
%token                  FOR_TOKEN
%token                  END_TOKEN
%token                  FALSE_TOKEN
%token                  TRUE_TOKEN
%token <integer>        INTEGER_TOKEN
%token <floating_point> FLOATING_POINT_TOKEN
%token <identifier>     IDENTIFIER_TOKEN

%right BREAK_TOKEN CONTINUE_TOKEN RETURN_TOKEN
%right '=' ADDITION_ASSIGNMENT_TOKEN SUBTRACTION_ASSIGNMENT_TOKEN MULTIPLICATION_ASSIGNMENT_TOKEN DIVISION_ASSIGNMENT_TOKEN MODULO_ASSIGNMENT_TOKEN
%left LOGICAL_OR_TOKEN
%left LOGICAL_AND_TOKEN
%left EQUAL_TO_TOKEN NOT_EQUAL_TO_TOKEN
%left '<' LESS_THAN_OR_EQUAL_TO_TOKEN '>' GREATER_THAN_OR_EQUAL_TO_TOKEN
%left '|'
%left '$'
%left '+' '-'
%left '*' '/' '%'
%right '!'
%left INCREMENT_TOKEN DECREMENT_TOKEN '(' ')' '{' '}' '[' ']' '.'

/* %nterm <expression> expression */

%start input

%code {
  #include "lexical_analyzer.h"

  void yyset_column(const int column, const yyscan_t scanner);

  static void yyerror(const YYLTYPE *yylloc, const yyscan_t scanner, VALUE *expression, const char *message);
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
  : declarations
  ;

declarations
  : declaration
  | declarations declaration
  ;

declaration
  : LET_TOKEN IDENTIFIER_TOKEN ':' type
  | VAR_TOKEN IDENTIFIER_TOKEN ':' type
  | definition
  ;

definition
  : LET_TOKEN IDENTIFIER_TOKEN '=' expression
  | VAR_TOKEN IDENTIFIER_TOKEN '=' expression
  | FUNC_TOKEN IDENTIFIER_TOKEN '(' ')' statements END_TOKEN
  | FUNC_TOKEN IDENTIFIER_TOKEN '(' types ')' statements END_TOKEN
  | FUNC_TOKEN IDENTIFIER_TOKEN '(' named_types ')' statements END_TOKEN
  | STRUCT_TOKEN IDENTIFIER_TOKEN declarations END_TOKEN
  | CLASS_TOKEN IDENTIFIER_TOKEN declarations END_TOKEN
  ;

types
  : type
  | types ',' type
  ;

type
  : IDENTIFIER_TOKEN
  | '(' types ')'
  | '(' named_types ')'
  | '{' types '}'
  | '{' named_types '}'
  | type '[' ']'
  | type '[' types ']'
  ;

named_types
  : named_type
  | named_types ',' named_type
  ;

named_type
  : IDENTIFIER_TOKEN ':' type
  ;

statements
  : expression
  | statements expression
  ;

expressions
  : expression
  | expressions ',' expression
  ;

expression
  : definition
  | if_expression
  | SWITCH_TOKEN expression case_expressions END_TOKEN
  | SWITCH_TOKEN expression case_expressions DEFAULT_TOKEN statements END_TOKEN
  | WHILE_TOKEN expression statements END_TOKEN
  | UNTIL_TOKEN expression statements END_TOKEN
  | FOR_TOKEN expression ';' expression ';' expression statements END_TOKEN
  | BREAK_TOKEN expression
  | CONTINUE_TOKEN expression
  | RETURN_TOKEN expression
  | expression '=' expression
  | expression ADDITION_ASSIGNMENT_TOKEN expression
  | expression SUBTRACTION_ASSIGNMENT_TOKEN expression
  | expression MULTIPLICATION_ASSIGNMENT_TOKEN expression
  | expression DIVISION_ASSIGNMENT_TOKEN expression
  | expression MODULO_ASSIGNMENT_TOKEN expression
  | expression LOGICAL_OR_TOKEN expression
  | expression LOGICAL_AND_TOKEN expression
  | expression EQUAL_TO_TOKEN expression
  | expression NOT_EQUAL_TO_TOKEN expression
  | expression '<' expression
  | expression LESS_THAN_OR_EQUAL_TO_TOKEN expression
  | expression '>' expression
  | expression GREATER_THAN_OR_EQUAL_TO_TOKEN expression
  | expression '|' expression
  | expression '$' expression
  | expression '+' expression
  | expression '-' expression
  | expression '*' expression
  | expression '/' expression
  | expression '%' expression
  | '!' expression
  | expression INCREMENT_TOKEN
  | expression DECREMENT_TOKEN
  | FALSE_TOKEN
  | TRUE_TOKEN
  | INTEGER_TOKEN
  | FLOATING_POINT_TOKEN
  | IDENTIFIER_TOKEN
  | '(' expressions ')'
  | '(' named_expressions ')'
  | '{' expressions '}'
  | '{' named_expressions '}'
  | '[' expressions ']'
  | '[' mapped_expressions ']'
  | expression '.' IDENTIFIER_TOKEN
  ;

if_expression
  : IF_TOKEN expression statements END_TOKEN
  | IF_TOKEN expression statements ELSE_TOKEN if_expression
  | UNLESS_TOKEN expression statements END_TOKEN
  | UNLESS_TOKEN expression statements ELSE_TOKEN if_expression
  ;

case_expressions
  : case_expression
  | case_expressions case_expression
  ;

case_expression
  : CASE_TOKEN expression statements
  ;

named_expressions
  : named_expression
  | named_expressions ',' named_expression
  ;

named_expression
  : IDENTIFIER_TOKEN ':' expression
  ;

mapped_expressions
  : mapped_expression
  | mapped_expressions ',' mapped_expression
  ;

mapped_expression
  : expressions ':' expression
  ;

%%

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

static void yyerror(const YYLTYPE *yylloc, const yyscan_t scanner, VALUE *expression, const char *message) {
  fprintf(stderr, "%i:%i: %s\n", yylloc->first_line, yylloc->first_column, message);
}
