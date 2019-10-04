require('mkmf')
require('pry')

SRC_EXT << ['y', 'l']

create_makefile('parser/parser') do |config|
  config << <<~MAKEFILE
    YACC := PATH="/usr/local/opt/bison/bin:$${PATH}" bison

    %.h: %.l
    	$(LEX) $(LFLAGS) --outfile=/dev/null --header-file=$(@) $(<)

    %.h: %.y
    	$(YACC) $(YFLAGS) --defines=$(@) --output-file=/dev/null $(<)

    %.c: %.y
    	$(YACC) $(YFLAGS) --output-file=$(@) $(<)

    .INTERMEDIATE: $(srcdir)/parser.h
    $(srcdir)/lexical_analyzer.o: $(srcdir)/parser.h

    .INTERMEDIATE: $(srcdir)/lexical_analyzer.h $(srcdir)/parser.h
    $(srcdir)/parser.o: $(srcdir)/lexical_analyzer.h $(srcdir)/parser.h
  MAKEFILE
end
