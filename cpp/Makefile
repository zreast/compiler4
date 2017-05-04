comp: comp.y comp.l
	bison -d comp.y
	flex  comp.l
	g++ comp.tab.c lex.yy.c -lfl -o out.comp -ggdb
clean:
	$(RM) comp.tab.c comp.tab.h lex.yy.c out.comp
