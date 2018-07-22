#!/usr/bin/env sh

# Usage:
#   run.sh save|check-utf8|check-gbk-big5 [--docker]

# Environment variables
if [ "$2" = "--docker" ]; then
  DOCKER_VOLUME="--volume packages:/miktex/.miktex --volume $(pwd):/miktex/work"
  DOCKER_IMAGE="nanmu42/tex-package-test-bench"
  DOCKER_RUN="docker run $DOCKER_VOLUME $DOCKER_IMAGE"
fi

SAVE="texlua build.lua save"
CHECK="texlua build.lua check --halt-on-error"

TESTFILES_UTF8=\
"
internal
api
user
encodings01
encodings02
encodings03
encodings04
encodings05
encodings06
encodings07
encodings08
compilation-utf8
"

TESTFILES_GBK_BIG5=\
"
cjk01
cjk02
cjk03
encodings01
encodings02
encodings03
encodings04
encodings05
encodings06
encodings07
encodings08
compilation-gbk
compilation-big5
"

CHECK_UTF8="$CHECK $TESTFILES_UTF8"
CHECK_GBK_BIG5="$CHECK --quiet --force --engine pdftex $TESTFILES_GBK_BIG5"

DIFF="./build/test/*.diff"
SHOW_DIFF="COUNT=`ls -1 $DIFF 2>/dev/null | wc -l`; if [ $COUNT != 0 ]; then tail -n +1 $DIFF; fi"

if [ "$2" = "--docker" ]; then
  if [ "$1" = "check-utf8" ]; then
    $DOCKER_RUN $CHECK_UTF8
  elif [ "$1" = "check-gbk-big5" ]; then
    $DOCKER_RUN $CHECK_GBK_BIG5
  fi
  $DOCKER_RUN bash -c "$SHOW_DIFF"
else
  if [ "$1" = "save" ]; then
    $SAVE --engine xetex  $TESTFILES_UTF8
    $SAVE --engine luatex $TESTFILES_UTF8
    $SAVE $TESTFILES_GBK_BIG5
  elif [ "$1" = "check-utf8" ]; then
    $CHECK_UTF8
  elif [ "$1" = "check-gbk-big5" ]; then
    $CHECK_GBK_BIG5
  fi
  $SHOW_DIFF
fi
