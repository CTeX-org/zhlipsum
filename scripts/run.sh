#!/usr/bin/env sh

# Usage:
#   run.sh save|check-utf8|check-gbk-big5 [--docker <image name>]

# Environment variable
if [ "$2" = "--docker" ]; then
  # See Dockerfile
  VOLUME=miktex
  MIKTEXDIR=/miktex/.miktex
  WORKDIR=/miktex/work
  DOCKER="docker run --volume $VOLUME:$MIKTEXDIR --volume $(pwd):$WORKDIR $3"
  TEXLUA="texlua --admin"
else
  TEXLUA="texlua"
fi
SAVE="$TEXLUA build.lua save"
CHECK="$TEXLUA build.lua check --halt-on-error"

TESTFILES_A=\
"
internal
api
user
encodings01
encodings02
encodings03
encodings04
encodings05
encodings06
encodings07
encodings08
compilation-utf8
"

TESTFILES_B=\
"
cjk01
cjk02
cjk03
encodings01
encodings02
encodings03
encodings04
encodings05
encodings06
encodings07
encodings08
compilation-gbk
compilation-big5
"

if [ "$2" = "--docker" ]; then
  $DOCKER ls -al
  $DOCKER pdflatex --version
  $DOCKER xelatex --version
  $DOCKER kpsewhich --version
  $DOCKER kpsewhich latex.ltx
  $DOCKER pdflatex --interaction=nonstopmode hello.tex
  $DOCKER xelatex --interaction=nonstopmode hello.tex
  #$DOCKER xelatex hello-zh.tex
  #if [ "$1" = "check-utf8" ]; then
  #  $DOCKER $CHECK $TESTFILES_A
  #elif [ "$1" = "check-gbk-big5" ]; then
  #  $DOCKER $CHECK --quiet --force --engine pdftex $TESTFILES_B
  #fi
else
  if [ "$1" = "save" ]; then
    $SAVE --engine xetex  $TESTFILES_A
    $SAVE --engine luatex $TESTFILES_A
    $SAVE $TESTFILES_B
  elif [ "$1" = "check-utf8" ]; then
    $CHECK $TESTFILES_A
  elif [ "$1" = "check-gbk-big5" ]; then
    $CHECK --quiet --force --engine pdftex $TESTFILES_B
  fi
fi
