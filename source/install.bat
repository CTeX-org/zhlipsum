@echo off

REM del *.sty
REM del *.def

xetex zhlipsum.ins

copy /Y "zhlipsum.sty"       "..\zhlipsum.sty"
copy /Y "zhlipsum-zh-cn.def" "..\zhlipsum-zh-cn.def"
copy /Y "zhlipsum.sty"       "..\test\zhlipsum.sty"
copy /Y "zhlipsum-zh-cn.def" "..\test\zhlipsum-zh-cn.def"