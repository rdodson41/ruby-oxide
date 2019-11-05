# frozen_string_literal: true

require('mkmf')

SRC_EXT << %w[l y]

$INCFLAGS << " -I$(srcdir)/../scanner"

create_makefile('parser/parser') do |config|
  config << <<~MAKEFILE.gsub(/  /, "\t")
    YACC := PATH="/usr/local/opt/bison/bin:$${PATH}" bison

    .DEFAULT_GOAL := all

    %.h: %.l
      $(LEX) $(LFLAGS) --outfile=/dev/null --header-file=$(@) $(<)

    %.c: %.l
      $(LEX) $(LFLAGS) --outfile=$(@) $(<)

    %.h: %.y
      $(YACC) $(YFLAGS) --defines=$(@) --output-file=/dev/null $(<)

    %.c: %.y
      $(YACC) $(YFLAGS) --output-file=$(@) $(<)

    .INTERMEDIATE: $(srcdir)/parser.h
    lexical_analyzer.o: $(srcdir)/parser.h

    .INTERMEDIATE: $(srcdir)/lexical_analyzer.h $(srcdir)/parser.h
    parser.o: $(srcdir)/lexical_analyzer.h $(srcdir)/parser.h
  MAKEFILE
end
