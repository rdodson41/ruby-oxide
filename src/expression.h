#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

typedef struct Expression Expression;

#include "expressions.h"

typedef enum ExpressionType {
  PIPE_EXPRESSION,
  APPLICATION_EXPRESSION,
  ADDITION_EXPRESSION,
  SUBTRACTION_EXPRESSION,
  MULTIPLICATION_EXPRESSION,
  DIVISION_EXPRESSION,
  EXPRESSIONS_EXPRESSION,
  INTEGER_EXPRESSION,
  FLOATING_POINT_EXPRESSION,
  IDENTIFIER_EXPRESSION,
  ASSIGNMENT_EXPRESSION,
  FUNCTION_EXPRESSION
} ExpressionType;

typedef struct Expression {
  ExpressionType type;
  Expression *left;
  Expression *right;
  Expressions *expressions;
  long integer;
  double floating_point;
  char *identifier;
} Expression;

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, Expressions *expressions, long integer, double floating_point, char *identifier);

void print_expression(Expression *expression, int level, int element);

void delete_expression(Expression *expression);

#endif
