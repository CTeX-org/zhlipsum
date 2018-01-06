#!/usr/bin/env sh

export NAME=zhlipsum

# Make TDS zip

mkdir -p TDS/doc/latex/$NAME/example/
mkdir -p TDS/tex/latex/$NAME/
mkdir -p TDS/source/latex/$NAME/
mkdir -p TDS/TEMP/

cp source/*.dtx TDS/TEMP/

cd TDS/TEMP/
xetex $NAME.dtx
texlua ../../scripts/get-doc-en.lua $NAME.dtx $NAME-en.tex
source ../../scripts/zhconvert.local.sh
cd ../..

mv TDS/TEMP/*.dtx               TDS/source/latex/$NAME/
mv TDS/TEMP/*.ins               TDS/source/latex/$NAME/
mv TDS/TEMP/*.sty               TDS/tex/latex/$NAME/
mv TDS/TEMP/*.def               TDS/tex/latex/$NAME/
mv TDS/TEMP/README.md           TDS/doc/latex/$NAME/
mv TDS/TEMP/$NAME-en.tex        TDS/doc/latex/$NAME/
mv TDS/TEMP/$NAME-example-*.tex TDS/doc/latex/$NAME/example/
cp source/*.pdf                 TDS/doc/latex/$NAME/

cd TDS/
rm -r TEMP/

zip -r -9 $NAME.tds.zip .
cd ..
mv -f TDS/$NAME.tds.zip .

# Make CTAN zip

mkdir CTAN/

cp TDS/source/latex/$NAME/*.dtx  CTAN/
cp TDS/doc/latex/$NAME/README.md CTAN/
cp TDS/doc/latex/$NAME/*.pdf     CTAN/
cp $NAME.tds.zip                 CTAN/

cd CTAN/
zip -r -9 $NAME.zip .
cd ..
mv -f CTAN/$NAME.zip .

rm -r TDS/
rm -r CTAN/
