MAKE=make
LATEX=latex
BIBTEX=bibtex
MAKEINDEX=makeindex
DVIPDFMX=dvipdfmx
LACHECK=lacheck
VAGRANT=vagrant

SOURCE_DIR=./
BUILD_DIR=_build/
SOURCES=$(addprefix $(SOURCE_DIR),main.tex main.bib)
SCRIPTS=$(addprefix $(SOURCE_DIR),Makefile)
OBJECTS=$(addprefix $(BUILD_DIR),main.pdf)
LOGS=$(addprefix $(BUILD_DIR),*.log *.blg *.ilg)
ARTIFACTS=$(OBJECTS) $(LOGS)

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

check: $(SOURCES)
	$(LACHECK) $^ > $(BUILD_DIR)lacheck.log

mostlyclean:
	-rm -f $(addprefix $(BUILD_DIR),\
	*.dvi *.aux *.out *.brf *.log \
	*.toc *.lof *.lot \
	*.idx *.ind *.ilg \
	*.bbl *.blg)

clean: mostlyclean
	-rm -f $(addprefix $(BUILD_DIR),*.pdf)
	-rm -fr $(BUILD_DIR)

vbuild: $(SOURCES) $(SCRIPTS)
	$(VAGRANT) up
	$(VAGRANT) ssh -c "cd /vagrant; cp -a --parents $(SOURCES) $(SCRIPTS) ~/"
	$(VAGRANT) ssh -c "mkdir -p $(BUILD_DIR)"
	$(VAGRANT) ssh -c "$(MAKE) check"
	$(VAGRANT) ssh -c "$(MAKE) build"
	$(VAGRANT) ssh -c "cp -a --parents $(ARTIFACTS) /vagrant; true"

vclean:
	$(VAGRANT) up
	$(VAGRANT) ssh -c "$(MAKE) clean"

vdestroy:
	$(VAGRANT) destroy
	-rm -fr .vagrant

help:
	@echo "Usage:"
	@echo "  vagrant box add latex-box latex-box-x.y.z.box"
	@echo "  make build  # build normally"
	@echo "  make vbuild # build in virtual environment"

.PHONY: all build check clean help vbuild vclean vdestroy

.PRECIOUS: $(ARTIFACTS)
