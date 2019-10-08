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

  if(element)
    printf("- ");

  switch(expression->type) {
    case FALSE_EXPRESSION:
      printf("type: 'false'\n");
      break;
    case TRUE_EXPRESSION:
      printf("type: 'true'\n");
      break;
    case INTEGER_EXPRESSION:
      printf("type: integer\n");
      break;
    case FLOATING_POINT_EXPRESSION:
      printf("type: floating_point\n");
      break;
    case IDENTIFIER_EXPRESSION:
      printf("type: identifier\n");
      break;
    case ASSIGNMENT_EXPRESSION:
      printf("type: assignment\n");
      break;
    case ADDITION_ASSIGNMENT_EXPRESSION:
      printf("type: addition_assignment\n");
      break;
    case SUBTRACTION_ASSIGNMENT_EXPRESSION:
      printf("type: subraction_assignment\n");
      break;
    case MULTIPLICATION_ASSIGNMENT_EXPRESSION:
      printf("type: multiplication_assignment\n");
      break;
    case DIVISION_ASSIGNMENT_EXPRESSION:
      printf("type: division_assignment\n");
      break;
    case MODULO_ASSIGNMENT_EXPRESSION:
      printf("type: modulo_assignment\n");
      break;
    case FUNCTION_EXPRESSION:
      printf("type: function\n");
      break;
    case OR_EXPRESSION:
      printf("type: or\n");
      break;
    case AND_EXPRESSION:
      printf("type: and\n");
      break;
    case EQUAL_EXPRESSION:
      printf("type: equal\n");
      break;
    case NOT_EQUAL_EXPRESSION:
      printf("type: not_equal\n");
      break;
    case LESS_THAN_EXPRESSION:
      printf("type: less_than\n");
      break;
    case LESS_THAN_OR_EQUAL_EXPRESSION:
      printf("type: less_than_or_equal\n");
      break;
    case GREATER_THAN_EXPRESSION:
      printf("type: greater_than\n");
      break;
    case GREATER_THAN_OR_EQUAL_EXPRESSION:
      printf("type: greater_than_or_equal\n");
      break;
    case PIPE_EXPRESSION:
      printf("type: pipe\n");
      break;
    case APPLICATION_EXPRESSION:
      printf("type: application\n");
      break;
    case ADDITION_EXPRESSION:
      printf("type: addition\n");
      break;
    case SUBTRACTION_EXPRESSION:
      printf("type: subtraction\n");
      break;
    case MULTIPLICATION_EXPRESSION:
      printf("type: multiplication\n");
      break;
    case DIVISION_EXPRESSION:
      printf("type: division\n");
      break;
    case MODULO_EXPRESSION:
      printf("type: modulo\n");
      break;
    case EXPRESSIONS_EXPRESSION:
      printf("type: expressions\n");
      break;
  }

  switch(expression->type) {
    case INTEGER_EXPRESSION:
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("integer: %li\n", expression->integer);
      break;
    case FLOATING_POINT_EXPRESSION:
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("floating_point: %lf\n", expression->floating_point);
      break;
    case IDENTIFIER_EXPRESSION:
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("identifier: %s\n", expression->identifier);
      break;
    case ASSIGNMENT_EXPRESSION:
    case ADDITION_ASSIGNMENT_EXPRESSION:
    case SUBTRACTION_ASSIGNMENT_EXPRESSION:
    case MULTIPLICATION_ASSIGNMENT_EXPRESSION:
    case DIVISION_ASSIGNMENT_EXPRESSION:
    case MODULO_ASSIGNMENT_EXPRESSION:
    case FUNCTION_EXPRESSION:
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("identifier: %s\n", expression->identifier);
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("right:\n");
      print_expression(expression->right, level + element + 1, 0);
      break;
    case OR_EXPRESSION:
    case AND_EXPRESSION:
    case EQUAL_EXPRESSION:
    case NOT_EQUAL_EXPRESSION:
    case LESS_THAN_EXPRESSION:
    case LESS_THAN_OR_EQUAL_EXPRESSION:
    case GREATER_THAN_EXPRESSION:
    case GREATER_THAN_OR_EQUAL_EXPRESSION:
    case PIPE_EXPRESSION:
    case APPLICATION_EXPRESSION:
    case ADDITION_EXPRESSION:
    case SUBTRACTION_EXPRESSION:
    case MULTIPLICATION_EXPRESSION:
    case DIVISION_EXPRESSION:
    case MODULO_EXPRESSION:
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("left:\n");
      print_expression(expression->left, level + element + 1, 0);
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("right:\n");
      print_expression(expression->right, level + element + 1, 0);
      break;
    case EXPRESSIONS_EXPRESSION:
      for(int i = 0; i < level; i++)
        printf("  ");
      if(element)
        printf("  ");
      printf("expressions:\n");
      print_expressions(expression->expressions, level + element + 1);
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
