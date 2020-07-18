# Author: Andre Goderich 郭育賢 <yuhsien77@gmail>
#
# ===== Usage ================================================================
#
# make                  Clean and compile all TARGET files to PDF
# make <filename>.pdf   Compile <filename>.md to a PDF
#
# make clean            Get rid of all generated PDF files
#
# ============================================================================


TARGET = dissertation

PANDOC_FLAGS =\
	-F pandoc-crossref \
	-F pandoc-citeproc \
	--metadata-file=metadata.yaml \
	-N \

LATEX_FLAGS = \
	--pdf-engine=xelatex \

all: clean $(TARGET).pdf

$(TARGET).pdf: $(TARGET).md
	pandoc $(PANDOC_FLAGS) $(LATEX_FLAGS) -o $@ $(TARGET).md

clean:
	rm -f $(TARGET).pdf

.PHONY: all clean
