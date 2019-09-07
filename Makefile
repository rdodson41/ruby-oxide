SRC := src
OBJ := obj
BIN := bin

.DEFAULT_GOAL := all

$(SRC)/%.h: $(SRC)/%.l
	$(LEX) $(LFLAGS) --outfile=/dev/null --header-file=$(@) $(<)

$(SRC)/%.h: $(SRC)/%.y
	$(YACC) $(YFLAGS) --defines=$(@) --output-file=/dev/null $(<)

$(OBJ):
	mkdir -p $(@)

$(OBJ)/%.o: $(SRC)/%.c | $(OBJ)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $(@) $(<)

.INTERMEDIATE: $(SRC)/parser.h
$(OBJ)/lexical_analyzer.o: $(SRC)/parser.h

.INTERMEDIATE: $(SRC)/lexical_analyzer.h
$(OBJ)/parser.o: $(SRC)/lexical_analyzer.h

$(BIN)/oxide: $(OBJ)/lexical_analyzer.o $(OBJ)/parser.o $(OBJ)/expressions.o $(OBJ)/expression.o
	$(CC) $(LDFLAGS) $(^) $(LOADLIBES) $(LDLIBS) -o $(@)

.PHONY: all
all: $(BIN)/oxide

.PHONY: clean
clean:
	rm -f $(BIN)/oxide
	rm -fR $(OBJ)
