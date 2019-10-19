#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

typedef struct Expression Expression;

#include "expressions.h"
#include "ruby.h"

#define create_false_expression()                                      (create_expression(FALSE_EXPRESSION, NULL, NULL, NULL, 0, 0, NULL))
#define create_true_expression()                                       (create_expression(TRUE_EXPRESSION, NULL, NULL, NULL, 0, 0, NULL))
#define create_integer_expression(integer)                             (create_expression(INTEGER_EXPRESSION, NULL, NULL, NULL, (integer), 0, NULL))
#define create_floating_point_expression(floating_point)               (create_expression(FLOATING_POINT_EXPRESSION, NULL, NULL, NULL, 0, (floating_point), NULL))
#define create_identifier_expression(identifier)                       (create_expression(IDENTIFIER_EXPRESSION, NULL, NULL, NULL, 0, 0, (identifier)))
#define create_assignment_expression(identifier, right)                (create_expression(ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_addition_assignment_expression(identifier, right)       (create_expression(ADDITION_ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_subtraction_assignment_expression(identifier, right)    (create_expression(SUBTRACTION_ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_multiplication_assignment_expression(identifier, right) (create_expression(MULTIPLICATION_ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_division_assignment_expression(identifier, right)       (create_expression(DIVISION_ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_modulo_assignment_expression(identifier, right)         (create_expression(MODULO_ASSIGNMENT_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_function_expression(identifier, right)                  (create_expression(FUNCTION_EXPRESSION, NULL, (right), NULL, 0, 0, (identifier)))
#define create_or_expression(left, right)                              (create_expression(OR_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_and_expression(left, right)                             (create_expression(AND_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_equal_expression(left, right)                           (create_expression(EQUAL_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_not_equal_expression(left, right)                       (create_expression(NOT_EQUAL_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_less_than_expression(left, right)                       (create_expression(LESS_THAN_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_less_than_or_equal_expression(left, right)              (create_expression(LESS_THAN_OR_EQUAL_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_greater_than_expression(left, right)                    (create_expression(GREATER_THAN_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_greater_than_or_equal_expression(left, right)           (create_expression(GREATER_THAN_OR_EQUAL_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_pipe_expression(left, right)                            (create_expression(PIPE_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_application_expression(left, right)                     (create_expression(APPLICATION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_addition_expression(left, right)                        (create_expression(ADDITION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_subtraction_expression(left, right)                     (create_expression(SUBTRACTION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_multiplication_expression(left, right)                  (create_expression(MULTIPLICATION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_division_expression(left, right)                        (create_expression(DIVISION_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_modulo_expression(left, right)                          (create_expression(MODULO_EXPRESSION, (left), (right), NULL, 0, 0, NULL))
#define create_expression_expression(expression)                       (expression)
#define create_expressions_expression(expressions)                     (create_expression(EXPRESSIONS_EXPRESSION, NULL, NULL, (expressions), 0, 0, NULL))

typedef enum ExpressionType {
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

VALUE adapt_expression_to_hash(Expression *expression);

void delete_expression(Expression *expression);

#endif
