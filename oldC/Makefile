asm: asm.y asm.lex
	cp asm.lex asm.lex.bak
	bison -d asm.y
	flex  -o asm.lex.c asm.lex
	gcc  -o asm asm.lex.c asm.tab.c -lfl -lm 
	cp asm.lex.bak asm.lex
clean:
	$(RM) asm.lex.c asm.tab.c asm.tab.h asm
