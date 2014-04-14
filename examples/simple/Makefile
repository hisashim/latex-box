MAKE=make
LATEX=latex
DVIPDFMX=dvipdfmx

SOURCES=main.tex
OBJECTS=main.pdf

all: build

%.pdf: %.dvi
	$(DVIPDFMX) $<

%.dvi: %.tex
%.dvi: %.tex
	$(LATEX) $<
	$(LATEX) $<
	$(LATEX) $<

build: $(OBJECTS)

clean:
	rm -f *.pdf *.dvi *.aux *.log

help:
	@echo "Usage:"
	@echo "  make"

.PHONY: all build clean help
