@echo off

REM ***** CTAN *****

mkdir "CTAN\zhlipsum"

copy /Y "source\*.dtx"  "CTAN\zhlipsum"
copy /Y "source\*.ins"  "CTAN\zhlipsum"
copy /Y "source\*.pdf"  "CTAN\zhlipsum"
copy /Y "source\*.md"   "CTAN\zhlipsum"
copy /Y "test\*.sty"    "CTAN\zhlipsum"
copy /Y "test\*.def"    "CTAN\zhlipsum"
copy /Y "test\*.tex"    "CTAN\zhlipsum"

REM ***** TDS *****

mkdir "TDS\source\latex\zhlipsum"
mkdir "TDS\tex\latex\zhlipsum"
mkdir "TDS\doc\latex\zhlipsum"
mkdir "TDS\doc\latex\zhlipsum\example"

copy /Y "source\*.dtx"  "TDS\source\latex\zhlipsum"
copy /Y "source\*.ins"  "TDS\source\latex\zhlipsum"
copy /Y "test\*.sty"    "TDS\tex\latex\zhlipsum"
copy /Y "test\*.def"    "TDS\tex\latex\zhlipsum"
copy /Y "source\*.pdf"  "TDS\doc\latex\zhlipsum"
copy /Y "source\*.md"   "TDS\doc\latex\zhlipsum"
copy /Y "test\*.tex"    "TDS\doc\latex\zhlipsum\example"

REM ***** Make zip files *****

cd "TDS"
zip -r "TDS" .
cd ..

copy /Y "TDS\TDS.zip"   "TDS.zip"
copy /Y "TDS\TDS.zip"   "CTAN\TDS.zip"

cd "CTAN"
zip -r "CTAN" .
cd ..

copy /Y "CTAN\CTAN.zip" "zhlipsum.zip"

rmdir /S /Q "zhlipsum"
rmdir /S /Q "CTAN"
