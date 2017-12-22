#!/usr/bin/env sh

# This script is used for changing encoding from UTF-8 to GBK.

mv "zhlipsum-simp-gbk.def" "zhlipsum-simp-gbk.old.def"
mv "zhlipsum-trad-gbk.def" "zhlipsum-trad-gbk.old.def"

iconv --from-code=utf8 --to-code=gbk  \
  --output="zhlipsum-simp-gbk.def"         \
  "zhlipsum-simp-gbk.old.def"
iconv --from-code=utf8 --to-code=gbk  \
  --output="zhlipsum-trad-gbk.def"         \
  "zhlipsum-trad-gbk.old.def"

rm "zhlipsum-simp-gbk.old.def"
rm "zhlipsum-trad-gbk.old.def"
