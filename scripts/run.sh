#!/usr/bin/env sh

# Install `zhlipsum`
cd source
xetex zhlipsum.dtx

mv zhlipsum-gbk.def  zhlipsum-gbk.tmpa.def
mv zhlipsum-big5.def zhlipsum-big5.tmpa.def

# Convert encodings
iconv --from-code=utf8 --to-code=gbk  --output=zhlipsum-gbk.tmpb.def  zhlipsum-gbk.tmpa.def
iconv --from-code=utf8 --to-code=big5 --output=zhlipsum-big5.tmpb.def zhlipsum-big5.tmpa.def

# Convert a TeX document in Big5 encoding into `preprocessed' form
# Require CJK utilities
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
extconv <zhlipsum-big5.tmpb.def> zhlipsum-big5.def
extconv <zhlipsum-gbk.tmpb.def>  zhlipsum-gbk.def

rm *.tmpa.def
rm *.tmpb.def

mkdir     ../test/
cp *.sty  ../test/
cp *.def  ../test/
cp *.tex  ../test/

# Test
cd ../test/

export JOBNAME=zhlipsum-example

latex    -interaction=nonstopmode -jobname=latex-utf8    $JOBNAME-utf8
latex    -interaction=nonstopmode -jobname=latex-gbk     $JOBNAME-gbk
latex    -interaction=nonstopmode -jobname=latex-big5    $JOBNAME-big5

# Under pdflatex, CTeX can't set up fonts automatically on Linux.
# pdflatex -interaction=nonstopmode -jobname=pdflatex-utf8 $JOBNAME-gbk
# pdflatex -interaction=nonstopmode -jobname=pdflatex-gbk  $JOBNAME-utf8
pdflatex -interaction=nonstopmode -jobname=pdflatex-big5 $JOBNAME-big5

xelatex  -interaction=nonstopmode -jobname=xelatex-utf8  $JOBNAME-utf8
lualatex -interaction=nonstopmode -jobname=lualatex-utf8 $JOBNAME-utf8
uplatex  -interaction=nonstopmode -jobname=uplatex-utf8  $JOBNAME-utf8

dvipdfmx latex-utf8
dvipdfmx latex-gbk
dvipdfmx latex-big5
dvipdfmx uplatex-utf8
