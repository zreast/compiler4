cp asm.lex asm.lex.bak
flex -o asm.lex.c asm.lex
bison -d asm.y
gcc -o asm asm.lex.c asm.tab.c -lfl -lm
cp asm.lex.bak asm.lex
