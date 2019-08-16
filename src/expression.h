#ifndef __EXPRESSION_H__
#define __EXPRESSION_H__

typedef enum ExpressionType {
  PIPE_EXPRESSION,
  APPLICATION_EXPRESSION,
  ADDITION_EXPRESSION,
  SUBTRACTION_EXPRESSION,
  MULTIPLICATION_EXPRESSION,
  DIVISION_EXPRESSION,
  LITERAL_EXPRESSION,
  IDENTIFIER_EXPRESSION,
  FUNCTION_EXPRESSION
} ExpressionType;

typedef struct Expression {
  ExpressionType type;
  struct Expression *left;
  struct Expression *right;
  int literal;
  char *identifier;
} Expression;

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, int literal, char *identifier);

void print_expression(Expression *expression, int level);

void delete_expression(Expression *expression);

#endif
