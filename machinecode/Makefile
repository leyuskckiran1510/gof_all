EXEC=gol.out
run:all
	@./$(EXEC)
# 	@rm "./$(EXEC)"

all:
	@nasm -f elf64  -g  -F dwarf -l gol.lst  gol.asm
	@gcc -o ./$(EXEC) -ggdb gol.o -no-pie
