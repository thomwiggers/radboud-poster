BIBLATEX = biber
LATEX = pdflatex
MAINFILE = main
TIKZDIR = fig
TIKZ_FILES = $(wildcard $(TIKZDIR)/*.tikz)
PDFTIKZ_FILES = $(patsubst %.tikz,%.pdf,$(TIKZ_FILES))

$(TIKZDIR)/%.pdf: $(TIKZDIR)/%.tikz $(TIKZDIR)/common-preamble.tex
	cd $(TIKZDIR); \
	pdflatex $$(basename $<)

$(MAINFILE).pdf: *.tex *.bib ${PDFTIKZ_FILES}
	latexmk -pdf -pdflatex="$(LATEX) -interactive=batchmode -halt-on-error" -use-make $(MAINFILE)

.PHONY: preview
preview:
	latexmk -pdf -pvc -use-make $(MAINFILE)

.PHONY: clean
clean:
	-latexmk -C $(MAINFILE)
	-rm -f *.bbl *.run.xml *.nav *.snm *.bbl *.auxlock *.vrb

.PHONY: clean-figs
clean-figs:
	-rm -f $(TIKZDIR)/*.{pdf,log,aux}

.PHONY: pdf
pdf: $(MAINFILE).pdf

.PHONY: fixme
fixme:
	-grep -i "FIXME" *.tex

.PHONY: todo
todo: fixme
	-grep -i "TODO" *.tex

all: $(MAINFILE).pdf
