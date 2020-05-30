This is a simple diploma thesis (LaTeX) template for my supervised students.

# Contents

The diploma work related files:

File/Directory  |  Purpose
----|----
[`hegyhati.sty`](hegyhati.sty)  |  Contains the includes for the necessary packages and several useful macros. (see below)
[`diploma.tex`](diploma.tex)  |  The "master" LaTeX file, that is compiled.
[`references.bib`](references.bib) | BibTeX file for references
[`cover.pdf`](cover.pdf) | Cover pages formatted according to the University requirements.
`Parts/` | Directory of LaTeX files for chapters, sections, etc.
`Figures/` | Directory for figures.

Other files related for easy building, CI workflow:

File/Directory  |  Purpose
----|----
[`Makefile`](Makefile)  |  Simple makefile to build the project.
[`Docker/Dockerfile`](Docker/Dockerfile)  |  The Dockerfile for the [hegyhati/diploma-latex](https://hub.docker.com/repository/docker/hegyhati/diploma-latex) image.
[`.gitignore`](.gitignore) | Typical LaTeX gitignore.
[`.github/workflows`](.github/workflows/) | [GitHub Action workflow](https://github.com/hegyhati/Diploma_Work_Template/actions) 

