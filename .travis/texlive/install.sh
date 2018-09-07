#!/usr/bin/env sh

# From latex3
# https://github.com/latex3/latex3/blob/master/support/texlive.sh

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget https://mirrors.rit.edu/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl                                \
    --profile     ../.travis/texlive/texlive.profile  \
    --repository  https://mirrors.rit.edu/CTAN/systems/texlive/tlnet
  cd ..
fi

# DEBUG
ls -l /tmp/texlive
ls -l /tmp/texlive/bin

# Change default package repository
tlmgr option repository https://mirrors.rit.edu/CTAN/systems/texlive/tlnet

# Packages
tlmgr install     \
  adobemapping    \
  amsfonts        \
  amsmath         \
  caption         \
  cjk             \
  cjkpunct        \
  cjkutils        \
  cm              \
  ctablestack     \
  ctex            \
  currfile        \
  dvipdfmx        \
  environ         \
  etex            \
  etoolbox        \
  euenc           \
  fancyhdr        \
  fandol          \
  filehook        \
  fontspec        \
  graphics        \
  graphics-cfg    \
  graphics-def    \
  ifluatex        \
  ifxetex         \
  kantlipsum      \
  knuth-lib       \
  l3build         \
  l3experimental  \
  l3kernel        \
  l3packages      \
  latex-bin       \
  lm              \
  lm-math         \
  lualatex-math   \
  lualibs         \
  luaotfload      \
  luatex          \
  luatex85        \
  luatexbase      \
  luatexja        \
  metafont        \
  mfware          \
  ms              \
  oberdiek        \
  platex-tools    \
  preview         \
  psnfss          \
  tex             \
  tex-ini-files   \
  tools           \
  trimspaces      \
  ucharcat        \
  ulem            \
  unicode-data    \
  uplatex         \
  varwidth        \
  xcjk2uni        \
  xcolor          \
  xecjk           \
  xetex           \
  xkeyval         \
  xunicode        \
  zhmetrics       \
  zhmetrics-uptex \
  zhnumber

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
