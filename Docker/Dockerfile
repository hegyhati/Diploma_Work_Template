FROM ubuntu:18.04

RUN apt-get update && apt-get install --no-install-recommends -y \
  make \
  texlive-latex-extra \
  texlive-bibtex-extra \
  texlive-science \
  ghostscript \
  biber \
&& rm -rf /var/lib/apt/lists/*
