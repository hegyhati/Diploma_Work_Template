#!/bin/bash

latex diploma.tex
biber diploma
makeindex diploma.idx
latex diploma.tex
latex diploma.tex
dvips diploma.dvi
ps2pdf diploma.ps
