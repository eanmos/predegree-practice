# Required packages (Arch Linux):
#
# texlive-bibtexextra 2021.58697-1
# texlive-bin 2021.58686-4
# texlive-core 2021.58710-2
# texlive-fontsextra 2021.58704-1
# texlive-langcyrillic 2021.58426-1
# texlive-langextra 2021.58019-1
# texlive-langgreek 2021.57684-1
# texlive-latexextra 2021.58668-2
#
# (CTAN):
#
# biblatex-gost 1.22 2021-05-08
#
# How to install tlmgr: https://wiki.archlinux.org/title/TeX_Live#tlmgr

target := index

TEXMFHOME := texmf
TEXMFVAR := .texlive/texmf-var

PDFTEXOPT := --shell-escape

IMG_WIDTH := 2048

svgs := $(wildcard img/*.svg)
pngs := $(patsubst %.svg,%.png,$(svgs))

all:
	pdflatex $(PDFTEXOPT) $(target).tex
	biber $(target).bcf
	pdflatex $(PDFTEXOPT) $(target).tex

%.png: %.svg
	inkscape -w $(IMG_WIDTH) -o $@ $<

clean:
	$(RM) $(pngs) $(target).{log,aux,pdf,bcf,toc,run.xml,aux.bbl,aux.blg,bbl,blg} missfont.log

mostlyclean:
	$(RM) $(pngs) $(target).{log,aux,bcf,toc,run.xml,aux.bbl,aux.blg,bbl,blg} missfont.log

run:
	zathura $(target).pdf

.DELETE_ON_ERROR:
.PHONY: all clean mostlyclean run
