@echo off

mkdir "TDS\doc\latex\zhlipsum"
mkdir "TDS\tex\latex\zhlipsum"
mkdir "TDS\source\latex\zhlipsum"

copy /Y "doc\zhlipsum.pdf"    "TDS\doc\latex\zhlipsum\zhlipsum.pdf"
copy /Y "zhlipsum.sty"        "TDS\tex\latex\zhlipsum\zhlipsum.sty"
copy /Y "zhlipsum-zh-cn.def"  "TDS\tex\latex\zhlipsum\zhlipsum-zh-cn.def"
copy /Y "source\zhlipsum.dtx" "TDS\source\latex\zhlipsum\zhlipsum.dtx"
copy /Y "source\zhlipsum.ins" "TDS\source\latex\zhlipsum\zhlipsum.ins"
