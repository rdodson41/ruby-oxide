#include <ruby.h>

VALUE hello_world(VALUE self);

void Init_oxide() {
  VALUE oxide = rb_define_module("Oxide");
  rb_define_singleton_method(oxide, "hello_world", hello_world, 0);
}
