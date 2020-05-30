TEX = pdflatex -interaction nonstopmode
BIB = bibtex
GS = gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite 

COVER = cover
MAINDOCUMENT = diploma
BIBFILE = references.bib
FINALDOCUMENT = diploma_with_cover.pdf

all: $(MAINDOCUMENT).pdf 
	$(GS) -sOutputFile=$(FINALDOCUMENT) $(COVER).pdf $(MAINDOCUMENT).pdf 

spell::
	ispell *.tex

clean::
	rm -fv *.aux *.log *.bbl *.blg *.toc *.out *.lot *.lof *.loa $(MAINDOCUMENT).pdf $(FINALDOCUMENT)

$(MAINDOCUMENT).pdf: $(MAINDOCUMENT).tex $(MAINDOCUMENT).bbl 
	$(TEX) $(MAINDOCUMENT) 
	$(TEX) $(MAINDOCUMENT)

$(MAINDOCUMENT).bbl: $(MAINDOCUMENT).tex $(BIBFILE)
	$(TEX) $(MAINDOCUMENT)
	$(BIB) $(MAINDOCUMENT)
