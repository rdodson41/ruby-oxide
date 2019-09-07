#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

typedef struct Expression Expression;

#include "expressions.h"

#define create_pipe_expression(left, right)              (create_expression(PIPE_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_application_expression(left, right)       (create_expression(APPLICATION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_addition_expression(left, right)          (create_expression(ADDITION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_subtraction_expression(left, right)       (create_expression(SUBTRACTION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_multiplication_expression(left, right)    (create_expression(MULTIPLICATION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_division_expression(left, right)          (create_expression(DIVISION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_expression_expression(expression)         (expression)
#define create_expressions_expression(expressions)       (create_expression(EXPRESSIONS_EXPRESSION, NULL, NULL, (expressions), 0, 0, NULL))
#define create_integer_expression(integer)               (create_expression(INTEGER_EXPRESSION, NULL, NULL, NULL, (integer), 0, NULL))
#define create_floating_point_expression(floating_point) (create_expression(FLOATING_POINT_EXPRESSION, NULL, NULL, NULL, 0, (floating_point), NULL))
#define create_identifier_expression(identifier)         (create_expression(IDENTIFIER_EXPRESSION, NULL, NULL, NULL, 0, 0, (identifier)))
#define create_assignment_expression(identifier, right)  (create_expression(ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_function_expression(identifier, right)    (create_expression(FUNCTION_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))

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
