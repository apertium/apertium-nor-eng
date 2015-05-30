###############################################################################
## Makefile for Norwegian--English
###############################################################################

VERSION=0.1.0
LANG1=nor
LANG1b=nob
LANG1n=nno
LANG1ne=nn_e
LANG1na=nn_a
LANG2=eng
PREFIX1=$(LANG1)-$(LANG2)
PREFIX1b=$(LANG1b)-$(LANG2)
PREFIX1n=$(LANG1n)-$(LANG2)
PREFIX2=$(LANG2)-$(LANG1)
PREFIX2b=$(LANG2)-$(LANG1b)
PREFIX2n=$(LANG2)-$(LANG1n)

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
     $(PREFIX1).autopgen.bin \
     $(PREFIX2b).automorf.bin \
     $(PREFIX2n).automorf.bin \
     $(PREFIX2).rlx.bin \
     $(PREFIX2).prob \
     $(PREFIX2b).autobil.bin \
     $(PREFIX2n).autobil.bin \
     $(PREFIX2).autolex.bin \
     $(PREFIX2).t1x.bin \
     $(PREFIX2).t2x.bin \
     $(PREFIX2).t3x.bin \
     $(PREFIX2b).autogen.bin \
     $(PREFIX2n).autogen.bin

# This include defines goals for install-modes, .deps/.d and .mode files:
@ap_include@

###############################################################################
## Monolingual transducers
###############################################################################

# -------------------
# Norwegian analysis:
# -------------------

$(PREFIX1b).automorf.bin: $(AP_SRC1b)/$(LANG1b).automorf.bin $(PREFIX1).autobil.bin
	lt-trim $^ $@

$(PREFIX1n).automorf.bin: $(AP_SRC1n)/$(LANG1n).automorf.bin $(PREFIX1).autobil.bin
	lt-trim $^ $@

# -------------------
# Norwegian generation:
# ---------------------

$(PREFIX2b).autogen.bin: $(AP_SRC1b)/$(LANG1b).autogen.bin
	cp $< $@

$(PREFIX2n).autogen.bin: $(AP_SRC1n)/$(LANG1n).autogen.bin
	cp $< $@

# -------------------
# English analysis:
# -------------------

$(PREFIX2b).automorf.bin: $(AP_SRC2)/$(LANG2).automorf.bin $(PREFIX2b).autobil.bin
	lt-trim $^ $@

$(PREFIX2n).automorf.bin: $(AP_SRC2)/$(LANG2).automorf.bin $(PREFIX2n).autobil.bin
	lt-trim $^ $@

# -------------------
# English generation:
# ---------------------

$(PREFIX1).autogen.bin: $(AP_SRC2)/$(LANG2).autogen.bin
	cp $< $@


###############################################################################
## Tagger models
###############################################################################

$(PREFIX1b).prob: $(AP_SRC1b)/$(LANG1b).prob
	cp $< $@

$(PREFIX1n).prob: $(AP_SRC1n)/$(LANG1n).prob
	cp $< $@

$(PREFIX2).prob: $(AP_SRC2)/$(LANG2).prob
	cp $< $@

###############################################################################
## Disambiguation rules
###############################################################################

$(PREFIX1b).rlx.bin: $(AP_SRC1b)/apertium-$(LANG1b).$(LANG1b).rlx
	cg-comp $< $@

$(PREFIX1n).rlx.bin: $(AP_SRC1n)/apertium-$(LANG1n).$(LANG1n).rlx
	cg-comp $< $@

$(PREFIX2).rlx.bin: $(AP_SRC2)/apertium-$(LANG2).$(LANG2).rlx
	cg-comp $< $@

###############################################################################
## Bilingual dictionaries
###############################################################################

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp lr $< $@

$(PREFIX2b).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl --var-left $(LANG1b) $< $@

$(PREFIX2n).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl --var-left $(LANG1n) $< $@

###############################################################################
## Lexical selection rules
###############################################################################

$(PREFIX1).autolex.bin: $(BASENAME).$(PREFIX1).lrx
	lrx-comp $< $@

$(PREFIX2).autolex.bin: $(BASENAME).$(PREFIX2).lrx
	lrx-comp $< $@

###############################################################################
## Structural transfer rules
###############################################################################

$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX1).t2x.bin: $(BASENAME).$(PREFIX1).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX1).t3x.bin: $(BASENAME).$(PREFIX1).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@


$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t2x.bin: $(BASENAME).$(PREFIX2).t2x
	apertium-validate-interchunk $<
	apertium-preprocess-transfer $< $@

$(PREFIX2).t3x.bin: $(BASENAME).$(PREFIX2).t3x
	apertium-validate-postchunk $<
	apertium-preprocess-transfer $< $@

###############################################################################
## Postgeneration dictionaries
###############################################################################

$(PREFIX1).autopgen.bin: $(AP_SRC2)/$(LANG2).autopgen.bin
	cp $< $@

$(PREFIX2b).autopgen.bin: $(AP_SRC1b)/$(LANG1b).autopgen.bin
	cp $< $@

$(PREFIX2n).autopgen.bin: $(AP_SRC1n)/$(LANG1n).autopgen.bin
	cp $< $@


###############################################################################
## Distribution
###############################################################################

EXTRA_DIST= \
		$(BASENAME).$(PREFIX1).lrx \
		$(BASENAME).$(PREFIX1).dix \
		$(BASENAME).$(PREFIX2).lrx \
		$(BASENAME).$(PREFIX1).t1x \
		$(BASENAME).$(PREFIX1).t2x \
		$(BASENAME).$(PREFIX1).t3x \
		$(BASENAME).$(PREFIX2).t1x \
		$(BASENAME).$(PREFIX2).t2x \
		$(BASENAME).$(PREFIX2).t3x \
		modes.xml

###############################################################################
## Installation
###############################################################################

apertium_nor_engdir=$(prefix)/share/apertium/$(BASENAME)/

# Files which should be installed to $(prefix)/share/apertium/$(BASENAME)/:
apertium_nor_eng_DATA= \
	$(TARGETS_COMMON) \
	$(BASENAME).$(PREFIX1).t1x \
	$(BASENAME).$(PREFIX1).t2x \
	$(BASENAME).$(PREFIX1).t3x \
	$(BASENAME).$(PREFIX2).t1x \
	$(BASENAME).$(PREFIX2).t2x \
	$(BASENAME).$(PREFIX2).t3x

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1).mode

install-data-local: install-modes

###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes

###############################################################################
## Test
###############################################################################

test: all
	echo "eg er ein fisk" | apertium -d . nno-eng | tee .test-mt
	@echo "I am a fish" > .test-ref
	@diff .test-ref .test-mt
	echo "the house" | apertium -d . eng-nno | tee .test-mt
	@echo "huset" > .test-ref
	@diff .test-ref .test-mt
	@rm .test-ref .test-mt
