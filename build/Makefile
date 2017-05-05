comp: Flang.y Flang.l
	bison -d Flang.y
	flex  Flang.l
	g++ Flang.tab.c lex.yy.c -lfl -o out.comp -ggdb
clean:
	$(RM) Flang.tab.c Flang.tab.h lex.yy.c out.comp

