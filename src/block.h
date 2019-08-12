#ifndef __BLOCK_H__
#define __BLOCK_H__

typedef struct Block Block;

#include "expression.h"

typedef struct Block {
  struct Block *left;
  Expression *right;
} Block;

Block *create_block(Block *left, Expression *right);

int evaluate_block(Block *block);

void delete_block(Block *block);

#endif
