# Taken from:
# https://github.com/jez/pandoc-starter/blob/master/book-writeup/src/Makefile
#
# Author: Jake Zimmerman <jake@zimmerman.io>
#
# ===== Usage ================================================================
#
# NOTE:
#   When running these commands at the command line, replace $(TARGET) with
#   the actual value of the TARGET variable.
#
#
# make                  Compile all *.md files to PDFs
# make <filename>.pdf   Compile <filename>.md to a PDF
# make <filename>.tex   Generate the intermediate LaTeX for <filename>.md
#
# make view             Compile $(TARGET).md to a PDF, then view it
# make again            Force everything to recompile
#
# make clean            Get rid of all intermediate generated files
# make veryclean        Get rid of ALL generated files:
#
# make print            Send $(TARGET).pdf to the default printer:
#
# ============================================================================


TARGET = dissertation

SOURCES = $(shell find . -name '*.md')

PANDOC_FLAGS =\
	-F pandoc-crossref \
	-F pandoc-citeproc \
	--metadata-file=metadata.yaml \
	-N \

LATEX_FLAGS = \

PDF_ENGINE = xelatex
LATEX_FLAGS += --pdf-engine=$(PDF_ENGINE)

all: $(TARGET).pdf

$(TARGET).pdf: $(SOURCES)
	pandoc $(PANDOC_FLAGS) $(LATEX_FLAGS) -o $@ $(SOURCES)

$(TARGET).tex: $(SOURCES) template.tex
	pandoc --standalone $(PANDOC_FLAGS) -o $@ $(SOURCES)

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb tags || true

veryclean: clean
	rm -f $(TARGET).pdf

.PHONY: all clean veryclean view
