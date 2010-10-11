VERSION=0.1.0
LANG1=no
LANG1b=nb
LANG1n=nn
LANG2=en
PREFIX1=$(LANG1)-$(LANG2)
PREFIX1b=$(LANG1b)-$(LANG2)
PREFIX1n=$(LANG1n)-$(LANG2)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = \
     $(PREFIX1b).automorf.bin \
     $(PREFIX1b).rlx.bin \
     $(PREFIX1).lex.bin \
     $(PREFIX1).autobil.bin \
     $(PREFIX1).t1x.bin \
     $(PREFIX1).t2x.bin \
     $(PREFIX1).t3x.bin \
     $(PREFIX1).autogen.bin \
     $(PREFIX1).autopgen.bin

# Use this goal for creating .deps, otherwise make -j2 will give problems:
.deps/.d:
	if [ ! -d .deps ]; then mkdir .deps; fi
	touch $@

# Prevent the .d file from being removed automatically:
.PRECIOUS: .deps/.d

.deps/$(BASENAME).$(PREFIX1).dix: $(BASENAME).$(PREFIX1).dix lexchoicebil.xsl .deps/.d
	xsltproc lexchoicebil.xsl $(BASENAME).$(PREFIX1).dix > $@

# nb-en
$(PREFIX1b).automorf.bin: $(BASENAME).$(LANG1b).dix
	apertium-validate-dictionary $(BASENAME).$(LANG1b).dix
	lt-comp lr $(BASENAME).$(LANG1b).dix $@

$(PREFIX1b).rlx.bin: $(NN_NB)/apertium-nn-nb.nb-nn.rlx
	cg-comp $(NN_NB)/apertium-nn-nb.nb-nn.rlx $@


# nn-nn TODO


# no-en (files common to both nb-nn and nn-en)
$(PREFIX1).lex.bin: $(BASENAME).$(PREFIX1).lex
	cg-comp $(BASENAME).$(PREFIX1).lex $@

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	if [ ! -d .deps ]; then mkdir .deps; fi
	xsltproc lexchoicebil.xsl $(BASENAME).$(PREFIX1).dix > .deps/$(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary .deps/$(BASENAME).$(PREFIX1).dix
	lt-comp lr .deps/$(BASENAME).$(PREFIX1).dix $@

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $(BASENAME).$(PREFIX1).t1x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t1x $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-interchunk $(BASENAME).$(PREFIX1).t2x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t2x $@

$(PREFIX1).t3x.bin: $(BASENAME).$(PREFIX1).t3x
	apertium-validate-postchunk $(BASENAME).$(PREFIX1).t3x
	apertium-preprocess-transfer $(BASENAME).$(PREFIX1).t3x $@

$(PREFIX1).autogen.bin: $(MK_EN)/apertium-mk-en.en.dix
	apertium-validate-dictionary $(MK_EN)/apertium-mk-en.en.dix
	lt-comp rl $(MK_EN)/apertium-mk-en.en.dix $@

$(PREFIX1).autopgen.bin: $(MK_EN)/apertium-mk-en.post-en.dix
	apertium-validate-dictionary $(MK_EN)/apertium-mk-en.post-en.dix
	lt-comp lr $(MK_EN)/apertium-mk-en.post-en.dix $@


EXTRA_DIST=$(BASENAME).$(LANG1b).dix \
           $(BASENAME).$(PREFIX1b).rlx \
           $(BASENAME).$(PREFIX1b).rlx \
           $(PREFIX1).prob \
	   $(BASENAME).$(PREFIX1).dix \
	   $(BASENAME).$(PREFIX1).t1x \
	   $(BASENAME).$(PREFIX1).t2x \
	   $(BASENAME).$(PREFIX1).t3x \
	   modes.xml lexchoicebil.xsl

apertium_no_endir=$(prefix)/share/apertium/apertium-$(PREFIX1)/
apertium_modesdir=$(prefix)/share/apertium/modes/

modes/$(PREFIX1).mode: modes.xml
	apertium-validate-modes modes.xml
	apertium-gen-modes modes.xml
	cp *.mode modes/

apertium_no_en_DATA=$(PREFIX1b).automorf.bin \
		    $(PREFIX1b).rlx.bin            \
		    $(PREFIX1).lex.bin            \
                    $(PREFIX1).prob               \
                    $(PREFIX1).autobil.bin        \
                    $(PREFIX1).autogen.bin  \
                    $(PREFIX1).autopgen.bin  \
		    $(PREFIX1).t1x.bin            \
		    $(PREFIX1).t2x.bin            \
		    $(PREFIX1).t3x.bin            \
		    modes.xml 

noinst_DATA=modes/$(PREFIX1).mode

install-data-local:
	mv modes modes.bak
	apertium-gen-modes modes.xml apertium-$(PREFIX1)
	test -d $(DESTDIR)$(apertium_modesdir) || mkdir $(DESTDIR)$(apertium_modesdir)
	$(INSTALL_DATA) $(PREFIX1).mode $(DESTDIR)$(apertium_modesdir)
	rm $(PREFIX1).mode
	rm -rf modes
	mv modes.bak modes
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t1x $(DESTDIR)$(apertium_no_endir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t2x $(DESTDIR)$(apertium_no_endir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t3x $(DESTDIR)$(apertium_no_endir)

# $(INSTALL_DATA) $(PREFIX1b).mode $(DESTDIR)$(apertium_modesdir)
# $(INSTALL_DATA) $(PREFIX1n).mode $(DESTDIR)$(apertium_modesdir)
# rm $(PREFIX1b).mode $(PREFIX1n).mode 

CLEANFILES = -rf $(TARGETS_COMMON) modes .deps
