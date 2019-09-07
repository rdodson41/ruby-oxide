#include <stdio.h>
#include <stdlib.h>

#include "expressions.h"

Expressions *create_expressions(Expressions *left, Expression *right) {
  Expressions *expressions = (Expressions *)malloc(sizeof(Expressions));

  if(expressions == NULL)
    return NULL;

  expressions->left = left;
  expressions->right = right;

  return expressions;
}

void print_expressions(Expressions *expressions, int level) {
  if(expressions == NULL)
    return;

  print_expressions(expressions->left, level);
  print_expression(expressions->right, level, 1);
}

void delete_expressions(Expressions *expressions) {
  if(expressions == NULL)
    return;

  delete_expressions(expressions->left);
  delete_expression(expressions->right);

  free(expressions);
}
