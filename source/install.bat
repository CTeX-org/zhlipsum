@echo off

xetex zhlipsum.ins

copy /Y "zhlipsum.sty"       "..\zhlipsum.sty"
copy /Y "zhlipsum-zh-cn.def" "..\zhlipsum-zh-cn.def"

delete-aux.bat
del *.sty
del *.def
