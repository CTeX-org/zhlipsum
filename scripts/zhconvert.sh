#!/usr/bin/env sh

# This script is used for converting encoding from UTF-8 to GBK/Big5

mv zhlipsum-gbk.def  zhlipsum-gbk.tmpa.def
mv zhlipsum-big5.def zhlipsum-big5.tmpa.def

iconv --from-code=utf8 --to-code=gbk  --output=zhlipsum-gbk.def       zhlipsum-gbk.tmpa.def
iconv --from-code=utf8 --to-code=big5 --output=zhlipsum-big5.tmpb.def zhlipsum-big5.tmpa.def

# Convert a TeX document in Big5 encoding into `preprocessed' form
# From CJK utilities
echo *************************
echo ** Converting Big5/GBK **
echo *************************
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
extconv <zhlipsum-big5.tmpb.def> zhlipsum-big5.def
extconv <zhlipsum-gbk.tmpb.def>  zhlipsum-gbk.def

rm *.tmpa.def
rm *.tmpb.def
