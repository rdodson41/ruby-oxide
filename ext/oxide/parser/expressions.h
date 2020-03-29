#ifndef __EXPRESSIONS_H__
#define __EXPRESSIONS_H__

#define create_expression_expressions(expression) (create_expressions(NULL, (expression)))

typedef struct Expression Expression;
typedef struct Expressions Expressions;

struct Expressions {
  Expressions *expressions;
  Expression *expression;
};

Expressions *create_expressions(Expressions *expressions, Expression *expression);

VALUE expressions_to_hash(const Expressions *expressions);

void delete_expressions(Expressions *expressions);

#endif
