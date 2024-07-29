EXEC=gol.out
run:all
	@./$(EXEC)
# 	@rm "./$(EXEC)"

test:all
	@./$(EXEC) > file.txt
	@python ./temp.py

all:
	@nasm -f elf64  -g  -F dwarf -l gol.lst  gol.asm
	@gcc -o ./$(EXEC) -ggdb gol.o -no-pie

