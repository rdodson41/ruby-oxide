#include <stdio.h>
#include <stdlib.h>

#include "block.h"
#include "expression.h"

Block *create_block(Block *left, Expression *right) {
  Block *block = (Block *)malloc(sizeof(Block));

  if(block == NULL)
    return NULL;

  block->left = left;
  block->right = right;

  return block;
}

int evaluate_block(Block *block) {
  if(block == NULL)
    return 0;

  evaluate_block(block->left);
  return evaluate_expression(block->right);
}

void print_block(Block *block, int level) {
  if(block == NULL)
    return;

  print_block(block->left, level);
  print_expression(block->right, level);
}

void delete_block(Block *block) {
  if(block == NULL)
    return;

  delete_block(block->left);
  delete_expression(block->right);

  free(block);
}
