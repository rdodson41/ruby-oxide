#ifndef __EXPRESSIONS_H__
#define __EXPRESSIONS_H__

#include <ruby.h>
#include <stdlib.h>

typedef struct Expressions Expressions;

#include "expression.h"

#define create_expression_expressions(expression) (create_expressions(NULL, (expression)))

struct Expressions {
  Expressions *expressions;
  Expression *expression;
};

Expressions *create_expressions(Expressions *expressions, Expression *expression);

VALUE expressions_to_hash(Expressions *expressions);

void delete_expressions(Expressions *expressions);

#endif
