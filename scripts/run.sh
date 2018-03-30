#!/usr/bin/env sh

export SAVE="texlua build.lua save"
export CHECK="texlua build.lua check --halt-on-error"

export TESTFILES_A=\
"
internal
api
user
compilation-utf8
encodings01
encodings02
encodings03
encodings04
encodings05
encodings06
encodings07
encodings08
"

export TESTFILES_B=\
"
cjk01
cjk02
cjk03
compilation-gbk
compilation-big5
encodings01
encodings02
encodings03
encodings04
encodings05
encodings06
encodings07
encodings08
"

if [ "$1" = "save" ]; then
  $SAVE --engine xetex  $TESTFILES_A
  $SAVE --engine luatex $TESTFILES_A
  $SAVE $TESTFILES_B
elif [ "$1" = "check-utf8" ]; then
  $CHECK $TESTFILES_A
elif [ "$1" = "check-gbk-big5" ]; then
  $CHECK --quiet --force --engine pdftex $TESTFILES_B
fi
