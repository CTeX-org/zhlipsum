#!/usr/bin/env sh

# From latex3
# https://github.com/latex3/latex3/blob/master/support/texlive.profile

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../support/texlive.profile

  cd ..
fi

# TeX base
tlmgr install     \
  tex             \
  etex            \
  knuth-lib       \
  latex-bin       \
  tex-ini-files   \
  cm

# Fonts
tlmgr install     \
  adobemapping    \
  amsfonts        \
  fandol          \
  lm              \
  lm-math         \
  metafont        \
  mfware          \
  psnfss

# Other
tlmgr install     \
  amsmath         \
  caption         \
  ctablestack     \
  ctex            \
  currfile        \
  environ         \
  etoolbox        \
  fancyhdr        \
  filehook        \
  graphics        \
  graphics-cfg    \
  graphics-def    \
  ifluatex        \
  ifpdf           \
  ifxetex         \
  kantlipsum      \
  l3kernel        \
  l3experimental  \
  l3packages      \
  l3build         \
  lualatex-math   \
  lualibs         \
  luaotfload      \
  luatex          \
  luatex85        \
  luatexbase      \
  luatexja        \
  ms              \
  oberdiek        \
  preview         \
  tools           \
  trimspaces      \
  ucharcat        \
  ulem            \
  unicode-data    \
  uplatex         \
  varwidth        \
  xcolor          \
  xecjk           \
  xetex           \
  xkeyval         \
  xunicode        \
  zh­metrics       \
  zh­metrics-up­tex \
  zhnumber

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
