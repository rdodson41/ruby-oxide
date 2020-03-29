#include <ruby.h>
#include <errno.h>

#include "lexical_analyzer.h"

static void delete_scanner(void *scanner) {
  yylex_destroy(scanner);
}

static VALUE rb_fallocate_scanner(const VALUE rb_cScanner) {
  void *scanner;

  if(yylex_init(&scanner) != 0)
    rb_raise(rb_eRuntimeError, "%s", strerror(errno));

  return Data_Wrap_Struct(rb_cScanner, NULL, delete_scanner, scanner);
}

void Init_scanner() {
  const VALUE rb_mOxide = rb_define_module("Oxide");
  const VALUE rb_cScanner = rb_define_class_under(rb_mOxide, "Scanner", rb_cObject);

  rb_define_alloc_func(rb_cScanner, rb_fallocate_scanner);
}
