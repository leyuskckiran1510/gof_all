all:
	emcc -o gol.html gol.c --shell-file html_template/shell_minimal.html -s NO_EXIT_RUNTIME=1 -s "EXPORTED_RUNTIME_METHODS=['ccall','UTF8ToString', 'getValue']" -s "EXPORTED_FUNCTIONS=['_malloc']" 
