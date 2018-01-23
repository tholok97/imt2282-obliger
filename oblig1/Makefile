%.out: %.c
	gcc -Wall -o $@ $<
	clang-tidy $< -checks=* --
