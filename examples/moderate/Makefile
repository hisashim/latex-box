MAKE=make
LATEX=latex
BIBTEX=bibtex
MAKEINDEX=makeindex
DVIPDFMX=dvipdfmx

SOURCE_DIR=./
BUILD_DIR=_build/
SOURCES=$(addprefix $(SOURCE_DIR),main.tex main.bib)
OBJECTS=$(addprefix $(BUILD_DIR),main.pdf)

all: build

$(BUILD_DIR)%.pdf: $(BUILD_DIR)%.dvi
	mkdir -p $(dir $@)
	$(DVIPDFMX) -o $@ $<

%.dvi: %.tex
$(BUILD_DIR)%.dvi: $(SOURCE_DIR)%.tex
	mkdir -p $(dir $@)
	$(LATEX) -output-directory=$(dir $@) $<
	$(LATEX) -output-directory=$(dir $@) $<
	-$(BIBTEX) $(BUILD_DIR)$*
	-$(MAKEINDEX) $(BUILD_DIR)$*.idx
	$(LATEX) -output-directory=$(dir $@) $<
	$(LATEX) -output-directory=$(dir $@) $<
	$(LATEX) -output-directory=$(dir $@) $<

build: $(OBJECTS)

mostlyclean:
	-rm -f $(addprefix $(BUILD_DIR),\
	*.dvi *.aux *.out *.brf *.log \
	*.toc *.lof *.lot \
	*.idx *.ind *.ilg \
	*.bbl *.blg)

clean: mostlyclean
	-rm -f $(addprefix $(BUILD_DIR),*.pdf)
	-rm -fr $(BUILD_DIR)

help:
	@echo "Usage:"
	@echo "  make"

.PHONY: all build clean help
