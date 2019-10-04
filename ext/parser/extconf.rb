require('mkmf')
require('pry')

create_makefile('parser/parser') do |config|
  config << <<~MAKEFILE
    OBJS := $(OBJS) lexical_analyzer.o parser.o

    YACC := PATH="/usr/local/opt/bison/bin:$${PATH}" bison

    .DEFAULT_GOAL := all

    $(srcdir)/lexical_analyzer.h: $(srcdir)/lexical_analyzer.l
      $(LEX) $(LFLAGS) --outfile=/dev/null --header-file=$(@) $(<)

    $(srcdir)/parser.h: $(srcdir)/parser.y
      $(YACC) $(YFLAGS) --defines=$(@) --output-file=/dev/null $(<)

    $(srcdir)/parser.c: $(srcdir)/parser.y
      $(YACC) $(YFLAGS) --output-file=$(@) $(<)

    lexical_analyzer.o: $(srcdir)/parser.h

    parser.o: $(srcdir)/lexical_analyzer.h $(srcdir)/parser.h
  MAKEFILE
end
