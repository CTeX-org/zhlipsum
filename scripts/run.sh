#!/usr/bin/env sh

# Install `zhlipsum`
cd source
xetex zhlipsum.dtx

mv zhlipsum-gbk.def  zhlipsum-gbk.tmp.def
mv zhlipsum-big5.def zhlipsum-big5.tmp.def

# Convert encodings
iconv --from-code=utf8 --to-code=gbk  --output=zhlipsum-gbk.def  zhlipsum-gbk.tmp.def
iconv --from-code=utf8 --to-code=big5 --output=zhlipsum-big5.def zhlipsum-big5.tmp.def

rm *.tmp.def

mkdir     ../test/
cp *.sty  ../test/
cp *.def  ../test/
cp *.tex  ../test/

# Test
cd ../test/

export TEXOPT=-interaction=batchmode
export JOBNAME=zhlipsum-example

# latex    $TEXOPT -jobname=latex-utf8    $JOBNAME-utf8
# latex    $TEXOPT -jobname=latex-gbk     $JOBNAME-gbk
# latex    $TEXOPT -jobname=latex-big5    $JOBNAME-big5
# 
# # Under pdflatex, CTeX can't set up fonts automatically on Linux.
# # pdflatex $TEXOPT -jobname=pdflatex-utf8 $JOBNAME-gbk
# # pdflatex $TEXOPT -jobname=pdflatex-gbk  $JOBNAME-utf8
# pdflatex $TEXOPT -jobname=pdflatex-big5 $JOBNAME-big5

xelatex  $TEXOPT -jobname=xelatex-utf8  $JOBNAME-utf8
lualatex $TEXOPT -jobname=lualatex-utf8 $JOBNAME-utf8
uplatex  $TEXOPT -jobname=uplatex-utf8  $JOBNAME-utf8

# dvipdfmx latex-utf8
# dvipdfmx latex-gbk
# dvipdfmx latex-big5
# dvipdfmx uplatex-utf8

cd ..
