%.out: %.c
	gcc -pthread -Wall -o $@ $<
	clang-tidy $< -checks=* --
