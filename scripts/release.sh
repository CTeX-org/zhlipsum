#!/usr/bin/env sh

export NAME=zhlipsum

export TEX_PATH=TDS/tex/latex/$NAME
export DOC_PATH=TDS/doc/latex/$NAME
export SRC_PATH=TDS/source/latex/$NAME
export TEMP_PATH=TDS/TEMP

export DOC_EN_SCRIPT=scripts/get-doc-en.lua
export ZHCONVERT_SCRIPT=scripts/zhconvert.local.sh

# Make TDS zip

mkdir -p $SRC_PATH/
mkdir -p $TEX_PATH/
mkdir -p $DOC_PATH/
mkdir -p $TEMP_PATH/

cp source/*.dtx $TEMP_PATH/
cp source/*.pdf $TEMP_PATH/

# All files should be rw-rw-r--
chmod 664 $TEMP_PATH/*

cd $TEMP_PATH/
xetex $NAME.dtx
texlua ../../$DOC_EN_SCRIPT $NAME.dtx $NAME-en.tex
source ../../$ZHCONVERT_SCRIPT
cd ../..

mv $TEMP_PATH/*.dtx  $SRC_PATH/
mv $TEMP_PATH/*.ins  $SRC_PATH/
mv $TEMP_PATH/*.sty  $TEX_PATH/
mv $TEMP_PATH/*.def  $TEX_PATH/
mv $TEMP_PATH/*.md   $DOC_PATH/
mv $TEMP_PATH/*.tex  $DOC_PATH/
mv $TEMP_PATH/*.pdf  $DOC_PATH/

cd TDS/
rm -r TEMP/

zip -r -9 $NAME.tds.zip .
cd ..
mv -f TDS/$NAME.tds.zip .

# Make CTAN zip

mkdir CTAN/

cp $SRC_PATH/*.dtx  CTAN/
cp $DOC_PATH/*.md   CTAN/
cp $DOC_PATH/*.pdf  CTAN/
cp $NAME.tds.zip    CTAN/

cd CTAN/
zip -r -9 $NAME.zip .
cd ..
mv -f CTAN/$NAME.zip .

rm -r TDS/
rm -r CTAN/
