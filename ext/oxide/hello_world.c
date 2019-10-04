#include <ruby.h>

VALUE hello_world(VALUE self) {
  return rb_str_new2("hello world");
}
