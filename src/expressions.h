#ifndef __EXPRESSIONS_H__
#define __EXPRESSIONS_H__

typedef struct Expressions Expressions;

#include "expression.h"

typedef struct Expressions {
  Expressions *left;
  Expression *right;
} Expressions;

Expressions *create_expressions(Expressions *left, Expression *right);

void print_expressions(Expressions *expressions, int level);

void delete_expressions(Expressions *expressions);

#endif
