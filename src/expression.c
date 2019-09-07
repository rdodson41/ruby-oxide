#include <stdio.h>
#include <stdlib.h>

#include "expression.h"

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, long integer, double floating_point, char *identifier) {
  Expression *expression = (Expression *)malloc(sizeof(Expression));

  if(expression == NULL)
    return NULL;

  expression->type = type;
  expression->left = left;
  expression->right = right;
  expression->integer = integer;
  expression->floating_point = floating_point;
  expression->identifier = identifier;

  return expression;
}

void print_expression(Expression *expression, int level) {
  if(expression == NULL)
    return;

  for (int i = 0; i < level; i++)
    printf("  ");

  switch(expression->type) {
    case PIPE_EXPRESSION:
      printf("PIPE\n");
      break;
    case APPLICATION_EXPRESSION:
      printf("APPLICATION\n");
      break;
    case ADDITION_EXPRESSION:
      printf("ADDITION\n");
      break;
    case SUBTRACTION_EXPRESSION:
      printf("SUBTRACTION\n");
      break;
    case MULTIPLICATION_EXPRESSION:
      printf("MULTIPLICATION\n");
      break;
    case DIVISION_EXPRESSION:
      printf("DIVISION\n");
      break;
    case INTEGER_EXPRESSION:
      printf("INTEGER: %li\n", expression->integer);
      break;
    case FLOATING_POINT_EXPRESSION:
      printf("FLOATING: %lf\n", expression->floating_point);
      break;
    case IDENTIFIER_EXPRESSION:
      printf("IDENTIFIER: %s\n", expression->identifier);
      break;
    case FUNCTION_EXPRESSION:
      printf("FUNCTION: %s\n", expression->identifier);
      break;
  }

  switch(expression->type) {
    case PIPE_EXPRESSION:
    case APPLICATION_EXPRESSION:
    case ADDITION_EXPRESSION:
    case SUBTRACTION_EXPRESSION:
    case MULTIPLICATION_EXPRESSION:
    case DIVISION_EXPRESSION:
      print_expression(expression->left, level + 1);
      print_expression(expression->right, level + 1);
      break;
    case INTEGER_EXPRESSION:
    case FLOATING_POINT_EXPRESSION:
    case IDENTIFIER_EXPRESSION:
      break;
    case FUNCTION_EXPRESSION:
      print_expression(expression->right, level + 1);
      break;
  }
}

void delete_expression(Expression *expression) {
  if(expression == NULL)
    return;

  delete_expression(expression->left);
  delete_expression(expression->right);

  free(expression->identifier);

  free(expression);
}
