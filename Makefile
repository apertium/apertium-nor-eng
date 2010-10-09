
all:
	lt-comp lr apertium-no-en.nb.dix no-en.automorf.bin
	cg-comp $(NN_NB)/apertium-nn-nb.nb-nn.rlx no-en.rlx.bin
	cg-comp apertium-no-en.no-en.lex no-en.lex.bin
	if [ ! -d .deps ]; then mkdir .deps; fi
	xsltproc lexchoicebil.xsl apertium-no-en.no-en.dix > .deps/apertium-no-en.no-en.dix
	lt-comp lr .deps/apertium-no-en.no-en.dix no-en.autobil.bin
	lt-comp rl $(MK_EN)/apertium-mk-en.en.dix no-en.autogen.bin
	lt-comp lr $(MK_EN)/apertium-mk-en.post-en.dix no-en.autopgen.bin
	apertium-preprocess-transfer apertium-no-en.no-en.t1x no-en.t1x.bin
	apertium-preprocess-transfer apertium-no-en.no-en.t2x no-en.t2x.bin
	apertium-preprocess-transfer apertium-no-en.no-en.t3x no-en.t3x.bin
	apertium-gen-modes modes.xml
	cp *.mode modes/

clean:
	rm -rf modes no-en.automorf.bin no-en.rlx.bin no-en.lex.bin no-en.autobil.bin no-en.autogen.bin no-en.autopgen.bin
