all:
	pdflatex version2.tex && bibtex version2 && pdflatex version2.tex && pdflatex version2.tex