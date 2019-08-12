#include <stdlib.h>

#include "expression.h"

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, int value) {
  Expression *expression = (Expression *)malloc(sizeof(Expression));

  if(expression == NULL)
    return NULL;

  expression->type = type;
  expression->left = left;
  expression->right = right;
  expression->value = value;

  return expression;
}

Expression *create_addition(Expression *left, Expression *right) {
  return create_expression(ADDITION, left, right, 0);
}

Expression *create_subtraction(Expression *left, Expression *right) {
  return create_expression(SUBTRACTION, left, right, 0);
}

Expression *create_multiplication(Expression *left, Expression *right) {
  return create_expression(MULTIPLICATION, left, right, 0);
}

Expression *create_division(Expression *left, Expression *right) {
  return create_expression(DIVISION, left, right, 0);
}

Expression *create_literal(int value) {
  return create_expression(LITERAL, NULL, NULL, value);
}

int evaluate_expression(Expression *expression) {
  switch(expression->type) {
    case ADDITION:
      return evaluate_expression(expression->left) + evaluate_expression(expression->right);
    case SUBTRACTION:
      return evaluate_expression(expression->left) - evaluate_expression(expression->right);
    case MULTIPLICATION:
      return evaluate_expression(expression->left) * evaluate_expression(expression->right);
    case DIVISION:
      return evaluate_expression(expression->left) / evaluate_expression(expression->right);
    case LITERAL:
      return expression->value;
    default:
      return 0;
  }
}

void delete_expression(Expression *expression) {
  if(expression == NULL)
    return;

  delete_expression(expression->left);
  delete_expression(expression->right);

  free(expression);
}
