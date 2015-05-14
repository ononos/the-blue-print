PDFNAME=The_Blueprint
HTMLNAME=The_blueprint.html

RND_OUT=./book/${HTMLNAME}\
	./book/${PDFNAME}.pdf\
	./book/${PDFNAME}-A4.pdf

MAIN_SRC = \
	create_pdf.tex \
	createA4_pdf.tex \
	create_html.tex	\
	tex/shared.tex \
	tex/preface.tex \
	tex/main.tex

DIST_SRC= Makefile\
	${MAIN_SRC}\
	${RND_OUT}

DIST_NAME="tbp"


help:
	@echo "You can use next make targets:"
	@echo "  make pdf      create pdf (A5)"
	@echo "  make pdfA4    create pdf (A4)"
	@echo "  make xpdf     create pdf (A5) and runt with xpdf"
	@echo "  make html     create html version, (you need hevea)"
	@echo "  make all      create PDFs & html (you need hevea)"
	@echo "  make dst      create TAR archive (PDFs & html)"

pdf:
	@echo "==> 1 pass"
	pdflatex create_pdf.tex
	@echo "==> 2 pass"
	pdflatex create_pdf.tex
	mkdir -p book
	mv -fv create_pdf.pdf ./book/${PDFNAME}.pdf

pdfA4:
	@echo "==> 1 pass"
	pdflatex createA4_pdf.tex
	@echo "==> 2 pass"
	pdflatex createA4_pdf.tex
	mkdir -p book
	mv -fv createA4_pdf.pdf ./book/${PDFNAME}-A4.pdf

xpdf: pdf
	xpdf ./book/${PDFNAME}.pdf

.PHONY : clean
clean:
	rm -f *.aux *.dvi *.log *.toc *.pdf *.ind *.and *.idx ./html *.habr *.hind\
	 *.haux *.htoc *.html *.htran *.ilg *.out \
	./book/* \
	${DIST_NAME}.tar.gz

html:
	hevea create_html.tex
	hevea create_html.tex
	mkdir -p book
	mv -f create_html.html ./book/${HTMLNAME}

zip:
	zip ${DIST_NAME}.zip ${DIST_SRC}

all: pdf pdfA4 html

dist: 	clean all
	tar -pczf ${DIST_NAME}.tar.gz ${DIST_SRC}
