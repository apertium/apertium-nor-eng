
all:
	lt-comp lr ../../trunk/apertium-nn-nb/apertium-nn-nb.nb.dix no-en.automorf.bin
	lt-comp lr apertium-no-en.no-en.dix no-en.autobil.bin
	lt-comp rl ../../trunk/apertium-mk-en/apertium-mk-en.en.dix no-en.autogen.bin
