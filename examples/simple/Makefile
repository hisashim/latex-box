MAKE=make
LATEX=latex
DVIPDFMX=dvipdfmx
VAGRANT=vagrant

SOURCES=main.tex
SCRIPTS=Makefile
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

vbuild: $(SOURCES) $(SCRIPTS)
	$(VAGRANT) up
	$(VAGRANT) ssh -c "cd /vagrant; cp -a --parents $(SOURCES) $(SCRIPTS) ~/"
	$(VAGRANT) ssh -c "$(MAKE) build"
	$(VAGRANT) ssh -c "cp -a --parents $(OBJECTS) /vagrant"

vdestroy:
	$(VAGRANT) destroy
	rm -fr .vagrant

help:
	@echo "Usage:"
	@echo "  vagrant box add latex-box latex-box-x.y.z.box"
	@echo "  make build  # build normally"
	@echo "  make vbuild # build in virtual environment"

.PHONY: all build clean help vbuild vdestroy
