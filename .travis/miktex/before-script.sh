#!/usr/bin/env sh

# Allow all files in working directory to be read/written/executed.
chmod --recursive 777 .

# Docker variables
DOCKER_VOLUME="--volume packages:/miktex/.miktex --volume $(pwd):/miktex/work"
DOCKER_IMAGE="nanmu42/tex-package-test-bench"
DOCKER_RUN="docker run $DOCKER_VOLUME $DOCKER_IMAGE"

# Install packages automatically
$DOCKER_RUN pdflatex --interaction=nonstopmode .travis/miktex/bootstrap-cjk.tex
$DOCKER_RUN xelatex  --interaction=nonstopmode .travis/miktex/bootstrap-ctex.tex
$DOCKER_RUN lualatex --interaction=nonstopmode .travis/miktex/bootstrap-ctex.tex
