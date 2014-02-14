bVERSION=0.1.0
LANG1=nor
LANG1b=nob
LANG1n=nno
LANG1ne=nn_e
LANG1na=nn_a
LANG2=eng
PREFIX1=$(LANG1)-$(LANG2)
PREFIX1b=$(LANG1b)-$(LANG2)
PREFIX1n=$(LANG1n)-$(LANG2)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON = \
     $(PREFIX1n).automorf.bin \
     $(PREFIX1n).rlx.bin \
     $(PREFIX1n).prob \
     $(PREFIX1b).automorf.bin \
     $(PREFIX1b).rlx.bin \
     $(PREFIX1b).prob \
     $(PREFIX1).autobil.bin \
     $(PREFIX1).autolex.bin \
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

#.deps/$(BASENAME).$(PREFIX1).dix: $(BASENAME).$(PREFIX1).dix lexchoicebil.xsl .deps/.d
#	xsltproc lexchoicebil.xsl $(BASENAME).$(PREFIX1).dix > $@

# nob-eng
$(PREFIX1b).automorf.bin: $(AP_LIB1b)/$(LANG1b).automorf.bin $(PREFIX1).autobil.bin
	lt-trim $(AP_LIB1b)/$(LANG1b).automorf.bin $(PREFIX1).autobil.bin $@	

$(PREFIX1b).rlx.bin: $(AP_SRC1b)/apertium-$(LANG1b).$(LANG1b).rlx
	cg-comp $< $@

$(PREFIX1b).prob: $(AP_LIB1b)/$(LANG1b).prob
	cp $< $@

# nno-eng
$(PREFIX1n).automorf.bin: $(AP_LIB1n)/$(LANG1n).automorf.bin $(PREFIX1).autobil.bin
	lt-trim $(AP_LIB1n)/$(LANG1n).automorf.bin $(PREFIX1).autobil.bin $@

$(PREFIX1n).rlx.bin: $(AP_SRC1n)/apertium-$(LANG1n).$(LANG1n).rlx
	cg-comp $< $@

$(PREFIX1n).prob: $(AP_LIB1n)/$(LANG1n).prob
	cp $< $@

# no-en (files common to both nb-nn and nn-en)
$(PREFIX1).autolex.bin: $(BASENAME).$(PREFIX1).lrx
	lrx-comp $(BASENAME).$(PREFIX1).lrx $@

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	if [ ! -d .deps ]; then mkdir .deps; fi
	apertium-validate-dictionary $(BASENAME).$(PREFIX1).dix
	lt-comp lr $(BASENAME).$(PREFIX1).dix $@

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
           $(PREFIX1n).prob \
           $(PREFIX1b).prob \
	   $(BASENAME).$(PREFIX1).lrx \
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

apertium_no_en_DATA=$(TARGETS_COMMON) \
		    modes.xml 

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1).mode

install-data-local:
	mv modes modes.bak
	apertium-gen-modes modes.xml apertium-$(PREFIX1)
	rm -rf modes
	mv modes.bak modes
	test -d $(DESTDIR)$(apertium_modesdir) || mkdir $(DESTDIR)$(apertium_modesdir)
	modes=`xmllint --xpath '//mode[@install="yes"]/@name' modes.xml | sed 's/ *name="\([^"]*\)"/\1.mode /g'`; \
		$(INSTALL_DATA) $$modes $(DESTDIR)$(apertium_modesdir); \
		rm $$modes
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t1x $(DESTDIR)$(apertium_no_endir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t2x $(DESTDIR)$(apertium_no_endir)
	$(INSTALL_DATA) $(BASENAME).$(PREFIX1).t3x $(DESTDIR)$(apertium_no_endir)

CLEANFILES = $(TARGETS_COMMON)
clean-local: 
	-rm -rf .deps modes
