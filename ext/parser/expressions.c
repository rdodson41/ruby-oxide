#include <stdio.h>
#include <stdlib.h>

#include "expressions.h"
#include "ruby.h"

Expressions *create_expressions(Expressions *left, Expression *right) {
  Expressions *expressions = (Expressions *)malloc(sizeof(Expressions));

  if(expressions == NULL)
    return NULL;

  expressions->left = left;
  expressions->right = right;

  return expressions;
}

VALUE adapt_expressions_to_hash(Expressions *expressions) {
  if(expressions == NULL)
    return Qnil;

  VALUE rb_vexpressions = rb_hash_new();

  if(expressions->left != NULL)
    rb_funcall(rb_vexpressions, rb_intern("[]="), 2, ID2SYM(rb_intern("left")), adapt_expressions_to_hash(expressions->left));

  if(expressions->right != NULL)
    rb_funcall(rb_vexpressions, rb_intern("[]="), 2, ID2SYM(rb_intern("right")), adapt_expression_to_hash(expressions->right));

  return rb_vexpressions;
}

void delete_expressions(Expressions *expressions) {
  if(expressions == NULL)
    return;

  delete_expressions(expressions->left);
  delete_expression(expressions->right);

  free(expressions);
}
