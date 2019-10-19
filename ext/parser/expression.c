#include <stdio.h>
#include <stdlib.h>

#include "expression.h"
#include "ruby.h"

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, Expressions *expressions, long integer, double floating_point, char *identifier) {
  Expression *expression = (Expression *)malloc(sizeof(Expression));

  if(expression == NULL)
    return NULL;

  expression->type = type;
  expression->left = left;
  expression->right = right;
  expression->expressions = expressions;
  expression->integer = integer;
  expression->floating_point = floating_point;
  expression->identifier = identifier;

  return expression;
}

VALUE adapt_expression_to_hash(Expression *expression) {
  if(expression == NULL)
    return Qnil;

  VALUE rb_vexpression = rb_hash_new();

  switch(expression->type) {
    case FALSE_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("false")));
      break;
    case TRUE_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("true")));
      break;
    case INTEGER_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("integer")));
      break;
    case FLOATING_POINT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("floating_point")));
      break;
    case IDENTIFIER_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("identifier")));
      break;
    case ASSIGNMENT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("assignment")));
      break;
    case ADDITION_ASSIGNMENT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("addition_assignment")));
      break;
    case SUBTRACTION_ASSIGNMENT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("subraction_assignment")));
      break;
    case MULTIPLICATION_ASSIGNMENT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("multiplication_assignment")));
      break;
    case DIVISION_ASSIGNMENT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("division_assignment")));
      break;
    case MODULO_ASSIGNMENT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("modulo_assignment")));
      break;
    case FUNCTION_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("function")));
      break;
    case OR_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("or")));
      break;
    case AND_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("and")));
      break;
    case EQUAL_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("equal")));
      break;
    case NOT_EQUAL_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("not_equal")));
      break;
    case LESS_THAN_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("less_than")));
      break;
    case LESS_THAN_OR_EQUAL_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("less_than_or_equal")));
      break;
    case GREATER_THAN_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("greater_than")));
      break;
    case GREATER_THAN_OR_EQUAL_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("greater_than_or_equal")));
      break;
    case PIPE_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("pipe")));
      break;
    case APPLICATION_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("application")));
      break;
    case ADDITION_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("addition")));
      break;
    case SUBTRACTION_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("subtraction")));
      break;
    case MULTIPLICATION_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("multiplication")));
      break;
    case DIVISION_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("division")));
      break;
    case MODULO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("modulo")));
      break;
    case EXPRESSIONS_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("expressions")));
      break;
  }

  if(expression->left != NULL)
    rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("left")), adapt_expression_to_hash(expression->left));

  if(expression->right != NULL)
    rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("right")), adapt_expression_to_hash(expression->right));

  if(expression->expressions != NULL)
    rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("expressions")), adapt_expressions_to_hash(expression->expressions));

  rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("integer")), INT2NUM(expression->integer));
  rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("floating_point")), rb_float_new(expression->floating_point));

  if(expression->identifier != NULL)
    rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("identifier")), rb_str_new2(expression->identifier));

  return rb_vexpression;
}

void delete_expression(Expression *expression) {
  if(expression == NULL)
    return;

  delete_expression(expression->left);
  delete_expression(expression->right);
  delete_expressions(expression->expressions);

  if(expression->identifier != NULL)
    free(expression->identifier);

  free(expression);
}
