#include <ruby.h>

#include "expression.h"
#include "expressions.h"

Expression *create_expression(ExpressionType type, long integer, double floating_point, char *identifier, Expression *expression, Expression *left, Expression *right, Expressions *expressions) {
  Expression *this = (Expression *)malloc(sizeof(Expression));

  if(this == NULL)
    return NULL;

  this->type = type;
  this->integer = integer;
  this->floating_point = floating_point;
  this->identifier = identifier;
  this->expression = expression;
  this->left = left;
  this->right = right;
  this->expressions = expressions;

  return this;
}

VALUE expression_to_hash(Expression *this) {
  if(this == NULL)
    return Qnil;

  VALUE rb_vexpression = rb_hash_new();

  switch(this->type) {
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
    case MAPPED_TO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("mapped_to")));
      break;
    case LOGICAL_OR_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("logical_or")));
      break;
    case LOGICAL_AND_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("logical_and")));
      break;
    case EQUAL_TO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("equal_to")));
      break;
    case NOT_EQUAL_TO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("not_equal_to")));
      break;
    case LESS_THAN_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("less_than")));
      break;
    case LESS_THAN_OR_EQUAL_TO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("less_than_or_equal_to")));
      break;
    case GREATER_THAN_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("greater_than")));
      break;
    case GREATER_THAN_OR_EQUAL_TO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("type")), ID2SYM(rb_intern("greater_than_or_equal_to")));
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

  switch(this->type) {
    case INTEGER_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("integer")), INT2NUM(this->integer));
      break;
    case FLOATING_POINT_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("floating_point")), rb_float_new(this->floating_point));
      break;
    case IDENTIFIER_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("identifier")), rb_str_new2(this->identifier));
      break;
    case ASSIGNMENT_EXPRESSION:
    case ADDITION_ASSIGNMENT_EXPRESSION:
    case SUBTRACTION_ASSIGNMENT_EXPRESSION:
    case MULTIPLICATION_ASSIGNMENT_EXPRESSION:
    case DIVISION_ASSIGNMENT_EXPRESSION:
    case MODULO_ASSIGNMENT_EXPRESSION:
    case MAPPED_TO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("identifier")), rb_str_new2(this->identifier));
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("expression")), expression_to_hash(this->expression));
      break;
    case LOGICAL_OR_EXPRESSION:
    case LOGICAL_AND_EXPRESSION:
    case EQUAL_TO_EXPRESSION:
    case NOT_EQUAL_TO_EXPRESSION:
    case LESS_THAN_EXPRESSION:
    case LESS_THAN_OR_EQUAL_TO_EXPRESSION:
    case GREATER_THAN_EXPRESSION:
    case GREATER_THAN_OR_EQUAL_TO_EXPRESSION:
    case PIPE_EXPRESSION:
    case APPLICATION_EXPRESSION:
    case ADDITION_EXPRESSION:
    case SUBTRACTION_EXPRESSION:
    case MULTIPLICATION_EXPRESSION:
    case DIVISION_EXPRESSION:
    case MODULO_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("left")), expression_to_hash(this->left));
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("right")), expression_to_hash(this->right));
      break;
    case EXPRESSIONS_EXPRESSION:
      rb_funcall(rb_vexpression, rb_intern("[]="), 2, ID2SYM(rb_intern("expressions")), expressions_to_hash(this->expressions));
      break;
    default:
      break;
  }

  return rb_vexpression;
}

void delete_expression(Expression *this) {
  if(this == NULL)
    return;

  if(this->identifier != NULL)
    free(this->identifier);

  if(this->expression != NULL)
    delete_expression(this->expression);

  if(this->left != NULL)
    delete_expression(this->left);

  if(this->right != NULL)
    delete_expression(this->right);

  if(this->expressions != NULL)
    delete_expressions(this->expressions);

  free(this);
}
