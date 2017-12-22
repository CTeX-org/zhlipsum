#!/usr/bin/env sh

# This script is used for changing encoding from UTF-8 to GBK.

mv zhlipsum-gbk.def  zhlipsum-gbk.tmp.def
mv zhlipsum-big5.def zhlipsum-big5.tmp.def

iconv --from-code=utf8 --to-code=gbk  --output=zhlipsum-gbk.def  zhlipsum-gbk.tmp.def
iconv --from-code=utf8 --to-code=big5 --output=zhlipsum-big5.def zhlipsum-big5.tmp.def

rm *.tmp.def
