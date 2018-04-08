#!/usr/bin/env sh

# This script is used for converting encoding from UTF-8 to GBK/Big5.

JOB_NAME=zhlipsum

mv $JOB_NAME-gbk.def  $JOB_NAME-gbk.tmp.def
mv $JOB_NAME-big5.def $JOB_NAME-big5.tmp.def

iconv -f utf8 -t gbk  -o $JOB_NAME-gbk.def  $JOB_NAME-gbk.tmp.def
iconv -f utf8 -t big5 -o $JOB_NAME-big5.def $JOB_NAME-big5.tmp.def

rm *.tmp.def
