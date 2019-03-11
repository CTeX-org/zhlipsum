#!/usr/bin/env sh

# TEST_FILES_UTF8="internal api user encodings01 encodings02 encodings03 encodings04 encodings05 encodings06 encodings07 encodings08 compilation-utf8"
# TEST_FILES_GBK_BIG5="cjk01 cjk02 cjk03 encodings01 encodings02 encodings03 encodings04 encodings05 encodings06 encodings07 encodings08 compilation-gbk compilation-big5"


TEST_FILES_UTF8="internal api"
TEST_FILES_GBK_BIG5="cjk01 cjk02"

texlua build.lua save -e xetex  $TEST_FILES_UTF8
texlua build.lua save -e luatex $TEST_FILES_UTF8
texlua build.lua save $TEST_FILES_GBK_BIG5
