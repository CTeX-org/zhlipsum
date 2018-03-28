#!/usr/bin/env sh

export TESTFILES="01-internal 02-api 03-user 04-compilation"

texlua build.lua save --engine xetex  $TESTFILES
texlua build.lua save --engine luatex $TESTFILES

# texlua build.lua check --halt-on-error
