#include <stdlib.h>

#include "block.h"
#include "expression.h"

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, Block *block, int value) {
  Expression *expression = (Expression *)malloc(sizeof(Expression));

  if(expression == NULL)
    return NULL;

  expression->type = type;
  expression->left = left;
  expression->right = right;
  expression->block = block;
  expression->value = value;

  return expression;
}

Expression *create_addition_expression(Expression *left, Expression *right) {
  return create_expression(ADDITION, left, right, NULL, 0);
}

Expression *create_subtraction_expression(Expression *left, Expression *right) {
  return create_expression(SUBTRACTION, left, right, NULL, 0);
}

Expression *create_multiplication_expression(Expression *left, Expression *right) {
  return create_expression(MULTIPLICATION, left, right, NULL, 0);
}

Expression *create_division_expression(Expression *left, Expression *right) {
  return create_expression(DIVISION, left, right, NULL, 0);
}

Expression *create_block_expression(Block *block) {
  return create_expression(BLOCK, NULL, NULL, block, 0);
}

Expression *create_literal_expression(int value) {
  return create_expression(LITERAL, NULL, NULL, NULL, value);
}

int evaluate_expression(Expression *expression) {
  if(expression == NULL)
    return 0;

  switch(expression->type) {
    case ADDITION:
      return evaluate_expression(expression->left) + evaluate_expression(expression->right);
    case SUBTRACTION:
      return evaluate_expression(expression->left) - evaluate_expression(expression->right);
    case MULTIPLICATION:
      return evaluate_expression(expression->left) * evaluate_expression(expression->right);
    case DIVISION:
      return evaluate_expression(expression->left) / evaluate_expression(expression->right);
    case BLOCK:
      return evaluate_block(expression->block);
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
  delete_block(expression->block);

  free(expression);
}
