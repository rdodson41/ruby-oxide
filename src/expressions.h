#ifndef __EXPRESSIONS_H__
#define __EXPRESSIONS_H__

typedef struct Expressions Expressions;

#include "expression.h"

#define create_expressions_expressions(expressions, expression) (create_expressions((expressions), (expression)))
#define create_expression_expressions(expression)               (create_expressions(NULL, (expression)))

typedef struct Expressions {
  Expressions *left;
  Expression *right;
} Expressions;

Expressions *create_expressions(Expressions *left, Expression *right);

void print_expressions(Expressions *expressions, int level);

void delete_expressions(Expressions *expressions);

#endif
