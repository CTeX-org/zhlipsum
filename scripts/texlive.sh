#!/usr/bin/env sh

# From latex3
# https://github.com/latex3/latex3/blob/master/support/texlive.profile

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH

export PATH=/usr/local/texlive/2017/bin/x86_64-linux:$PATH

if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget https://mirrors.rit.edu/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl                                \
    --profile     ../scripts/texlive.profile  \
    --repository  https://mirrors.rit.edu/CTAN/systems/texlive/tlnet
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
  cjk             \
  cjkpunct        \
  cjkutils        \
  ctablestack     \
  ctex            \
  currfile        \
  environ         \
  etoolbox        \
  euenc           \
  fancyhdr        \
  filehook        \
  fontspec        \
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
  platex-tools    \
  preview         \
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
