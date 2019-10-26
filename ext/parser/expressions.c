#include <ruby.h>

#include "expression.h"
#include "expressions.h"

Expressions *create_expressions(Expressions *expressions, Expression *expression) {
  Expressions *this = (Expressions *)malloc(sizeof(Expressions));

  if(this == NULL)
    return NULL;

  this->expressions = expressions;
  this->expression = expression;

  return this;
}

VALUE expressions_to_hash(Expressions *this) {
  if(this == NULL)
    return Qnil;

  VALUE rb_vexpressions = rb_hash_new();

  if(this->expressions != NULL)
    rb_funcall(rb_vexpressions, rb_intern("[]="), 2, ID2SYM(rb_intern("expressions")), expressions_to_hash(this->expressions));

  if(this->expression != NULL)
    rb_funcall(rb_vexpressions, rb_intern("[]="), 2, ID2SYM(rb_intern("expression")), expression_to_hash(this->expression));

  return rb_vexpressions;
}

void delete_expressions(Expressions *this) {
  if(this == NULL)
    return;

  if(this->expressions != NULL)
    delete_expressions(this->expressions);

  if(this->expression != NULL)
    delete_expression(this->expression);

  free(this);
}
