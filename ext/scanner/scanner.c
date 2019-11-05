#include <ruby.h>
#include <sys/errno.h>

int yylex_init(void **scanner);

int yylex_destroy(void *scanner);

static void delete_scanner(void *scanner) {
	yylex_destroy(scanner);
}

static const rb_data_type_t rb_tscanner = {
	.wrap_struct_name = "scanner",
	.function = {
		.dmark = NULL,
		.dfree = &delete_scanner,
		.dsize = NULL
	},
	.data = NULL,
	.flags = RUBY_TYPED_FREE_IMMEDIATELY
};

static VALUE rb_fallocate_scanner(const VALUE rb_vscanner) {
  void *scanner;

  if(yylex_init(&scanner) != 0)
    rb_raise(rb_eRuntimeError, "%s", strerror(errno));

	return TypedData_Wrap_Struct(rb_vscanner, &rb_tscanner, scanner);
}

void Init_scanner() {
  const VALUE rb_mOxide = rb_define_module("Oxide");
  const VALUE rb_cScanner = rb_define_class_under(rb_mOxide, "Scanner", rb_cObject);

	rb_define_alloc_func(rb_cScanner, rb_fallocate_scanner);
}

void *unwrap_scanner(const VALUE rb_vscanner) {
	void *scanner;

	TypedData_Get_Struct(rb_vscanner, void *, &rb_tscanner, scanner);

	return scanner;
}
