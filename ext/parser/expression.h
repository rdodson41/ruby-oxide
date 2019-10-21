#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

#include <ruby.h>
#include <stdlib.h>

typedef enum ExpressionType ExpressionType;
typedef struct Expression Expression;

#include "expressions.h"

#define create_false_expression()                                           (create_expression(FALSE_EXPRESSION, 0, 0.0, NULL, NULL, NULL, NULL, NULL))
#define create_true_expression()                                            (create_expression(TRUE_EXPRESSION, 0, 0.0, NULL, NULL, NULL, NULL, NULL))
#define create_integer_expression(integer)                                  (create_expression(INTEGER_EXPRESSION, (integer), 0.0, NULL, NULL, NULL, NULL, NULL))
#define create_floating_point_expression(floating_point)                    (create_expression(FLOATING_POINT_EXPRESSION, 0, (floating_point), NULL, NULL, NULL, NULL, NULL))
#define create_identifier_expression(identifier)                            (create_expression(IDENTIFIER_EXPRESSION, 0, 0.0, (identifier), NULL, NULL, NULL, NULL))
#define create_assignment_expression(identifier, expression)                (create_expression(ASSIGNMENT_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_addition_assignment_expression(identifier, expression)       (create_expression(ADDITION_ASSIGNMENT_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_subtraction_assignment_expression(identifier, expression)    (create_expression(SUBTRACTION_ASSIGNMENT_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_multiplication_assignment_expression(identifier, expression) (create_expression(MULTIPLICATION_ASSIGNMENT_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_division_assignment_expression(identifier, expression)       (create_expression(DIVISION_ASSIGNMENT_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_modulo_assignment_expression(identifier, expression)         (create_expression(MODULO_ASSIGNMENT_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_function_expression(identifier, expression)                  (create_expression(FUNCTION_EXPRESSION, 0, 0.0, (identifier), (expression), NULL, NULL, NULL))
#define create_or_expression(left, right)                                   (create_expression(OR_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_and_expression(left, right)                                  (create_expression(AND_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_equal_expression(left, right)                                (create_expression(EQUAL_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_not_equal_expression(left, right)                            (create_expression(NOT_EQUAL_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_less_than_expression(left, right)                            (create_expression(LESS_THAN_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_less_than_or_equal_expression(left, right)                   (create_expression(LESS_THAN_OR_EQUAL_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_greater_than_expression(left, right)                         (create_expression(GREATER_THAN_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_greater_than_or_equal_expression(left, right)                (create_expression(GREATER_THAN_OR_EQUAL_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_pipe_expression(left, right)                                 (create_expression(PIPE_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_application_expression(left, right)                          (create_expression(APPLICATION_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_addition_expression(left, right)                             (create_expression(ADDITION_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_subtraction_expression(left, right)                          (create_expression(SUBTRACTION_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_multiplication_expression(left, right)                       (create_expression(MULTIPLICATION_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_division_expression(left, right)                             (create_expression(DIVISION_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_modulo_expression(left, right)                               (create_expression(MODULO_EXPRESSION, 0, 0.0, NULL, NULL, (left), (right), NULL))
#define create_expression_expression(expression)                            (expression)
#define create_expressions_expression(expressions)                          (create_expression(EXPRESSIONS_EXPRESSION, 0, 0.0, NULL, NULL, NULL, NULL, (expressions)))

enum ExpressionType {
  FALSE_EXPRESSION,
  TRUE_EXPRESSION,
  INTEGER_EXPRESSION,
  FLOATING_POINT_EXPRESSION,
  IDENTIFIER_EXPRESSION,
  ASSIGNMENT_EXPRESSION,
  ADDITION_ASSIGNMENT_EXPRESSION,
  SUBTRACTION_ASSIGNMENT_EXPRESSION,
  MULTIPLICATION_ASSIGNMENT_EXPRESSION,
  DIVISION_ASSIGNMENT_EXPRESSION,
  MODULO_ASSIGNMENT_EXPRESSION,
  FUNCTION_EXPRESSION,
  OR_EXPRESSION,
  AND_EXPRESSION,
  EQUAL_EXPRESSION,
  NOT_EQUAL_EXPRESSION,
  LESS_THAN_EXPRESSION,
  LESS_THAN_OR_EQUAL_EXPRESSION,
  GREATER_THAN_EXPRESSION,
  GREATER_THAN_OR_EQUAL_EXPRESSION,
  PIPE_EXPRESSION,
  APPLICATION_EXPRESSION,
  ADDITION_EXPRESSION,
  SUBTRACTION_EXPRESSION,
  MULTIPLICATION_EXPRESSION,
  DIVISION_EXPRESSION,
  MODULO_EXPRESSION,
  EXPRESSIONS_EXPRESSION
};

struct Expression {
  ExpressionType type;
  long integer;
  double floating_point;
  char *identifier;
  Expression *expression;
  Expression *left;
  Expression *right;
  Expressions *expressions;
};

Expression *create_expression(ExpressionType type, long integer, double floating_point, char *identifier, Expression *expression, Expression *left, Expression *right, Expressions *expressions);

VALUE expression_to_hash(Expression *this);

void delete_expression(Expression *this);

#endif
