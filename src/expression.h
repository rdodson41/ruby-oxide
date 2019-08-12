#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

typedef enum ExpressionType {
  ADDITION,
  SUBTRACTION,
  MULTIPLICATION,
  DIVISION,
  LITERAL
} ExpressionType;

typedef struct Expression {
  ExpressionType type;
  struct Expression *left;
  struct Expression *right;
  int value;
} Expression;

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, int value);

Expression *create_addition(Expression *left, Expression *right);

Expression *create_subtraction(Expression *left, Expression *right);

Expression *create_multiplication(Expression *left, Expression *right);

Expression *create_division(Expression *left, Expression *right);

Expression *create_literal(int value);

int evaluate_expression(Expression *expression);

void delete_expression(Expression *expression);

#endif
