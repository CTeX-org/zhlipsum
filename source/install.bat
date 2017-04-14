@echo off

xetex zhlipsum.ins

copy /Y "zhlipsum.sty"       "..\zhlipsum.sty"
copy /Y "zhlipsum-zh-cn.def" "..\zhlipsum-zh-cn.def"
copy /Y "zhlipsum.sty"       "..\test\zhlipsum.sty"
copy /Y "zhlipsum-zh-cn.def" "..\test\zhlipsum-zh-cn.def"

del *.sty
del *.def
delete-aux.bat
