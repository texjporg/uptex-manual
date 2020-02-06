DOCTARGET = uptex-manual
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
KANJI = -kanji=utf8
FONTMAP = -f ipaex.map -f uptex-ipaex.map
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)

default: $(DVITARGET)
all: $(PDFTARGET)

uptex-manual.dvi: uptex-manual.tex
	uplatex $(KANJI) uptex-manual.tex
	uplatex $(KANJI) uptex-manual.tex
	upmendex -s gind.ist -o uptex-manual.ind uptex-manual.idx
	uplatex $(KANJI) uptex-manual.tex
	rm -f *.aux *.log *.toc *.idx *.ind *.ilg *.out

.SUFFIXES: .tex .dvi .pdf
.tex.dvi:	
	platex $(KANJI) $<
	platex $(KANJI) $<
	platex $(KANJI) $<
	rm -f *.aux *.log *.toc
.dvi.pdf:
	dvipdfmx $(FONTMAP) $<

.PHONY: install clean
install:
	mkdir -p ${TEXMF}/doc/uptex/uptex-manual
	cp ./LICENSE ${TEXMF}/doc/uptex/uptex-manual/
	cp ./README* ${TEXMF}/doc/uptex/uptex-manual/
	cp ./*.tex ${TEXMF}/doc/uptex/uptex-manual/
	cp ./*.pdf ${TEXMF}/doc/uptex/uptex-manual/
clean:
	rm -f $(DVITARGET) $(PDFTARGET)
