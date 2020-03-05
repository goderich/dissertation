# Author: Andre Goderich 郭育賢 <yuhsien77@gmail>
# Based on:
# https://github.com/jez/pandoc-starter/blob/master/book-writeup/src/Makefile
# by Jake Zimmerman <jake@zimmerman.io>
#
# ===== Usage ================================================================
#
# make                  Clean and compile all TARGET files to PDF
# make <filename>.pdf   Compile <filename>.md to a PDF
# make <filename>.tex   Generate the intermediate LaTeX for <filename>.md
#
# make clean            Get rid of all generated PDF files
# make veryclean        Get rid of all generated files for LaTeX
#
# ============================================================================


TARGET = dissertation

SOURCE = dissertation.md

PANDOC_FLAGS =\
	-F pandoc-crossref \
	-F pandoc-citeproc \
	--metadata-file=metadata.yaml \
	-N \

LATEX_FLAGS = \
	--pdf-engine=xelatex \

all: clean $(TARGET).pdf

$(TARGET).pdf: $(SOURCE)
	pandoc $(PANDOC_FLAGS) $(LATEX_FLAGS) -o $@ $(SOURCE)

$(TARGET).tex: $(SOURCE) template.tex
	pandoc --standalone $(PANDOC_FLAGS) -o $@ $(SOURCE)

clean:
	rm -f $(TARGET).pdf

veryclean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb tags || true

.PHONY: all clean veryclean view
