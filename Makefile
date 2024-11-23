COMPILER=gcc

scanner: lex.yy.o
	$(COMPILER) lex.yy.o -o scanner

lex.yy.o: lex.yy.c
	$(COMPILER) -c lex.yy.c -o lex.yy.o

lex.yy.c: reglas.l
	flex reglas.l

test:
	./scanner tests/test.ok.micro
	echo **********************
	./scanner tests/test.error-lex.micro

clean:
	del lex.yy.c lex.yy.o
