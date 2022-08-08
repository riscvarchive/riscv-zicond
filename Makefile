HEADER_SOURCE := header.adoc

SPEC=riscv-zicondops
DATE=$(shell date  +%Y%m%d)
VERSION=$(shell git describe --tag --always --dirty)
PDF_RESULT := $(SPEC)-$(VERSION).pdf

all: $(PDF_RESULT)

$(PDF_RESULT):
	@echo "Building asciidoc"
	asciidoctor-pdf \
    --attribute=mathematical-format=svg \
    --attribute=pdf-fontsdir=docs-resources/fonts \
    --attribute=pdf-style=docs-resources/themes/riscv-pdf.yml \
    --failure-level=ERROR \
    --require=asciidoctor-bibtex \
    --require=asciidoctor-diagram \
    --require=asciidoctor-mathematical \
    --out-file=$@ \
    $(HEADER_SOURCE)
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -sOutputFile=opt-$@ $@ && mv opt-$@ $@

clean:
	-rm -f $(SPEC)-*.pdf
