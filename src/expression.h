#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

typedef struct Expression Expression;

#include "block.h"

typedef enum ExpressionType {
  ADDITION,
  SUBTRACTION,
  MULTIPLICATION,
  DIVISION,
  BLOCK,
  LITERAL
} ExpressionType;

typedef struct Expression {
  ExpressionType type;
  struct Expression *left;
  struct Expression *right;
  Block *block;
  int value;
} Expression;

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, Block *block, int value);

Expression *create_addition_expression(Expression *left, Expression *right);

Expression *create_subtraction_expression(Expression *left, Expression *right);

Expression *create_multiplication_expression(Expression *left, Expression *right);

Expression *create_division_expression(Expression *left, Expression *right);

Expression *create_block_expression(Block *block);

Expression *create_literal_expression(int value);

int evaluate_expression(Expression *expression);

void delete_expression(Expression *expression);

#endif
