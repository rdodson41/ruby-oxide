#include <stdio.h>
#include <stdlib.h>

#include "expression.h"

Expression *create_expression(ExpressionType type, Expression *left, Expression *right, Expressions *expressions, long integer, double floating_point, char *identifier) {
  Expression *expression = (Expression *)malloc(sizeof(Expression));

  if(expression == NULL)
    return NULL;

  expression->type = type;
  expression->left = left;
  expression->right = right;
  expression->expressions = expressions;
  expression->integer = integer;
  expression->floating_point = floating_point;
  expression->identifier = identifier;

  return expression;
}

void print_expression(Expression *expression, int level, int element) {
  if(expression == NULL)
    return;

  for(int i = 0; i < level; i++)
    printf("  ");

  if(element != 0)
    printf("- ");

  switch(expression->type) {
    case PIPE_EXPRESSION:
      printf("pipe:\n");
      break;
    case APPLICATION_EXPRESSION:
      printf("application:\n");
      break;
    case ADDITION_EXPRESSION:
      printf("addition:\n");
      break;
    case SUBTRACTION_EXPRESSION:
      printf("subtraction:\n");
      break;
    case MULTIPLICATION_EXPRESSION:
      printf("multiplication:\n");
      break;
    case DIVISION_EXPRESSION:
      printf("division:\n");
      break;
    case EXPRESSIONS_EXPRESSION:
      printf("expressions:\n");
      break;
    case INTEGER_EXPRESSION:
      printf("integer: %li\n", expression->integer);
      break;
    case FLOATING_POINT_EXPRESSION:
      printf("floating_point: %lf\n", expression->floating_point);
      break;
    case IDENTIFIER_EXPRESSION:
      printf("identifier: %s\n", expression->identifier);
      break;
    case ASSIGNMENT_EXPRESSION:
      printf("assignment:\n");
      break;
    case FUNCTION_EXPRESSION:
      printf("function:\n");
      break;
  }

  switch(expression->type) {
    case PIPE_EXPRESSION:
    case APPLICATION_EXPRESSION:
    case ADDITION_EXPRESSION:
    case SUBTRACTION_EXPRESSION:
    case MULTIPLICATION_EXPRESSION:
    case DIVISION_EXPRESSION:
      for(int i = 0; i < level + 1; i++)
        printf("  ");
      if(element != 0)
        printf("  ");
      printf("left:\n");
      print_expression(expression->left, level + 2 + element, 0);
      for(int i = 0; i < level + 1; i++)
        printf("  ");
      if(element != 0)
        printf("  ");
      printf("right:\n");
      print_expression(expression->right, level + 2 + element, 0);
      break;
    case EXPRESSIONS_EXPRESSION:
      print_expressions(expression->expressions, level + 1);
      break;
    case ASSIGNMENT_EXPRESSION:
    case FUNCTION_EXPRESSION:
      for(int i = 0; i < level + 1; i++)
        printf("  ");
      if(element != 0)
        printf("  ");
      printf("identifier: %s\n", expression->identifier);
      for(int i = 0; i < level + 1; i++)
        printf("  ");
      if(element != 0)
        printf("  ");
      printf("right:\n");
      print_expression(expression->right, level + 2 + element, 0);
      break;
    default:
      break;
  }
}

void delete_expression(Expression *expression) {
  if(expression == NULL)
    return;

  delete_expression(expression->left);
  delete_expression(expression->right);
  delete_expressions(expression->expressions);

  if(expression->identifier != NULL)
    free(expression->identifier);

  free(expression);
}
