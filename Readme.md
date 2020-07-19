Instructions for using this repository as a template for writing a thesis (diploma work) in LaTeX.

# Directory structure

The thesis related files:

File/Directory  |  Purpose
----|----
[`hegyhati.sty`](hegyhati.sty)  |  Contains the includes for the necessary packages and several useful macros (see below)
[`diploma.tex`](diploma.tex)  |  The "master" LaTeX file, that is compiled
[`references.bib`](references.bib) | BibTeX file for references
[`cover.pdf`](cover.pdf) | Cover pages formatted according to the University requirements
[`Parts/`](Parts/) | Directory of LaTeX files for chapters, sections, etc.
`Figures/` | Directory for figures

Other files related for easy building, CI workflow:

File/Directory  |  Purpose
----|----
[`Makefile`](Makefile)  |  Simple makefile to build the project
[`Docker/Dockerfile`](Docker/Dockerfile)  |  The Dockerfile for the [hegyhati/diploma-latex](https://hub.docker.com/repository/docker/hegyhati/diploma-latex) image
[`.gitignore`](.gitignore) | Typical LaTeX gitignore
[`.github/workflows`](.github/workflows/) | [GitHub Actions workflow](https://github.com/hegyhati/Diploma_Work_Template/actions) configuration files

# Compiling the thesis

## Regular way

If you have a Linux-based system, simply run `make`, and it will:
 - run `pdflatex`
 - run `bibtex`
 - run `pdflatex` twice
 - merge `cover.pdf` and the generated `diploma.pdf` into a single `diploma_with_cover.pdf` 

To get rid of the generated files (pdf included) simply run `make clean`.

In order to have the necessary commands executed my `make`, several packages need to be installed, which can differ for each distribution. The [Dockerfile](Docker/Dockerfile) provides these packages for Ubuntu 18.04.

## The Docker way

If you don't want to install these packages on your host system, but have `docker`, simply mount this directory into a container and do it there:
```
docker run --rm -v ${PWD}:/project -w /project hegyhati/diploma-latex:latest make
```
You can similarly run `make clean` as well, although it only uses `rm` so there isn't much reason to do so.

To make building in docker a bit easier, `docker-all` is specified in the makefile target, with the command above. So you can just run the following if you have `make` and `docker` but not the LaTeX packages.
```
make docker-all
```

## The "GitHub way" 

Just push the changes to the repository, and [this simple workflow](.github/workflows/build.yml) will build it for you, and `diploma_with_cover.pdf` will be available as an artifact.

# Extending the build environment

If your thesis requires additional LaTeX packages, either create a new docker image (preferred), or extend the [workflow](.github/workflows/build.yml) with installing those packages.

## Example

Let's say you need the `texlive-games` packages. Here is what you have to do:
1. Change the dockerfile to:
```
FROM hegyhati/diploma-latex:latest
RUN apt-get update && apt-get install --no-install-recommends -y \
  texlive-games \
&& rm -rf /var/lib/apt/lists/*
```
2. Build it with `docker build -t yourdockerusername/diploma-latex` and `docker push`
3. Update the [Makefile](makefile) and the [CI workflow](.github/workflows/build.yml) to use your new docker image

# LaTeX macros

## Handy small macros

Command | Parameters | Result
---|---|---
`\Emph` | `{text}` | Formats text bold and italic for emphasis.
`\CodeName` | `{text}` | Formats monospace and bold for filenames, identifiers in code, etc.
`\Todo` | `{message}` | Inserts a flashy red message about an urgent and important todo in the document.
`\TodoLater` | `{message}` | Inserts a less intrusive green message in the footnote about non-urgent todo.

Use these within the document everywhere, and change their action as you see fit.

## Partitioning the document

Command | Parameters | Result
---|---|---
`\Chapter` | `{title}` `{name}` | Defines a new chapter with the title given in `title`, and assigns a label with the id `chapter_name`. Then, it inputs `Parts/name.tex`. `name` may contain a path as well, e.g. `Introduction/litreview`.
`\ChapterShort` | `{shorttitle}` `{title}` `{name}` | Same as above, but uses `shorttitle` in the TOC and header. (Use if chapter title is too long.)
`\ChapterUnnumbered` | `{title}` `{name}` `{toctitle}` | Adds a chapter, without numbering, `toctitle` is how it appears in the TOC. (Usually used for abstracts, acknowledgements, etc.)
`\Section` | `{title}` `{name}` | Same as `\Chapter` but for sections, the defined label id is `section_name`.
`\SectionShort` | `{shorttitle}` `{title}` `{name}` | Same as `\ChapterShort` but for sections.
`\Subsection` | `{title}` `{name}` | Same as `\Chapter` but for subsections, the defined label id is `subsection_name`.
`\Subsubsection` | `{title}` `{name}` | Same as `\Chapter` but for subsubsections, the defined label id is `subsubsection_name`.

## Figures, Tables, Pseudo codes, Code segments

Command | Parameters | Result
---|---|---
`\Figure` | `{filename}` `{caption}` `{options}` | Includes the file `Figures/filename` with `option` options passed to `\includegraphics`, e.g., `width=8cm`. `filename` must contain the extension, and may include a path. It is also used to define a label with id `fig_filename`. `caption` is used for caption. Everything is wrapped in a figure floating block with `htpb` positioning.
`\FigureShort` | `{filename}` `{shortcaption}` `{caption}` `{options}` | Same as above, only `shortcaption` will appear in the list of figures.
`\Table` | `{labelsuffix}` `{caption}` `{columndef}` `{tablecontent}` | Creates a tabular block with column definition `columndef` (e.g. <code>r\|\|c\|c\|c\|</code>), `htpb` positioning, and with the content in `tablecontent`. General rules of LaTeX tables apply. `caption` will be used as a caption, and a label is defined with an id `tab_labelsuffix`.
`\TableShort` | `{labelsuffix}` `{shortcaption}` `{caption}` `{columndef}` `{tablecontent}` | Same as above, only `shortcaption` will appear in list of tables.
`\Algorithm` | `{label}` `{caption}` `{pseudocode}` | Creates a floating algorithm block with content in `pseudocode`, that should use the syntax of the algorithmic package. Caption is set to `caption`, and a label with id `alg_label` is defined. `\LETE` command is also defined for assignment.
`\AlgorithmShort` | `{label}` `{shortcaption}` `{caption}` `{pseudocode}` | Same as above, only `shortcaption` appears in the list of algorithms.
`\Code` | `{labelsuffix}` `{caption}` `{language}` `{code}` | Will be used for including source codes with lstlistings. Not provided yet. 
