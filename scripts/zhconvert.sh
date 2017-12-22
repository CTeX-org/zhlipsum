#!/usr/bin/env sh

# This script is used for changing encoding from UTF-8 to GBK.

jobname=zhlipsum-simp

mv "$jobname-gbk.def" "$jobname-gbk.old.def"

iconv --from-code=utf8 --to-code=gbk  \
  --output="$jobname-gbk.def"         \
  "$jobname-gbk.old.def"

rm "$jobname-gbk.old.def"
