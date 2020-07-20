TEX = pdflatex -interaction nonstopmode
BIB = bibtex
GS = gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite

COVER = cover
MAINDOCUMENT = thesis
BIBFILE = references.bib
FINALDOCUMENT = thesis_with_cover.pdf
STYLE = hegyhati.sty
PARTS = $(shell find Parts/ -type f)
FIGURES = $(shell find Figures/ -type f)

all: $(MAINDOCUMENT).pdf $(COVER).pdf
	$(GS) -sOutputFile=$(FINALDOCUMENT) $(COVER).pdf $(MAINDOCUMENT).pdf

spell::
	ispell *.tex

clean::
	rm -fv *.aux *.log *.bbl *.blg *.toc *.out *.lot *.lof *.loa $(MAINDOCUMENT).pdf $(FINALDOCUMENT)

$(MAINDOCUMENT).pdf: $(MAINDOCUMENT).tex $(MAINDOCUMENT).bbl $(STYLE) $(PARTS) $(FIGURES)
	$(TEX) $(MAINDOCUMENT)
	$(TEX) $(MAINDOCUMENT)

$(MAINDOCUMENT).bbl: $(MAINDOCUMENT).tex $(BIBFILE)
	$(TEX) $(MAINDOCUMENT)
	$(BIB) $(MAINDOCUMENT)

docker-all::
	docker run --rm -v ${PWD}:/project -w /project hegyhati/diploma-latex:latest make
