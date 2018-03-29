#!/usr/bin/env sh

export SAVE="texlua build.lua save"
export CHECK="texlua build.lua check --halt-on-error"

export TESTFILES_A="01-internal 02-api 03-user 04-compilation"
export TESTFILES_B="05-gbk 06-big5"

if [ "$1" = "save" ]; then
  $SAVE --engine xetex  $TESTFILES_A
  $SAVE --engine luatex $TESTFILES_A
  $SAVE $TESTFILES_B
elif [ "$1" = "check-utf8" ]; then
  $CHECK $TESTFILES_A
elif [ "$1" = "check-gbk-big5" ]; then
  $CHECK --quiet --force --engine pdftex $TESTFILES_B
fi
