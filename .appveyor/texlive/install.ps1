Get-ChildItem
Invoke-WebRequest -Uri "https://mirrors.rit.edu/CTAN/systems/texlive/tlnet/install-tl.zip" `
                  -OutFile "install-tl.zip"
Expand-Archive "install-tl.zip" -DestinationPath .
Set-Location "install-tl-20*"

.\install-tl-advanced.bat -no-gui `
                          -profile     ../.appveyor/texlive/texlive.profile `
                          -repository  https://mirrors.rit.edu/CTAN/systems/texlive/tlnet

Write-Output $env:PATH
$env:PATH += ";C:\texlive\bin\win32"
Write-Output $env:PATH

# DEBUG
Get-ChildItem "C:\texlive"
Get-ChildItem "C:\texlive\bin"
Get-ChildItem "C:\texlive\bin\win32"
Get-ChildItem "C:\texlive\texmf-dist"

Get-Content "C:\texlive\install-tl.log"

# Change default package repository
tlmgr option repository https://mirrors.rit.edu/CTAN/systems/texlive/tlnet

# Packages
tlmgr install     `
  adobemapping    `
  amsfonts        `
  amsmath         `
  caption         `
  cjk             `
  cjkpunct        `
  cjkutils        `
  cm              `
  ctablestack     `
  ctex            `
  currfile        `
  dvipdfmx        `
  environ         `
  etex            `
  etoolbox        `
  euenc           `
  fancyhdr        `
  fandol          `
  filehook        `
  fontspec        `
  graphics        `
  graphics-cfg    `
  graphics-def    `
  ifluatex        `
  ifxetex         `
  kantlipsum      `
  knuth-lib       `
  l3build         `
  l3experimental  `
  l3kernel        `
  l3packages      `
  latex-bin       `
  lm              `
  lm-math         `
  lualatex-math   `
  lualibs         `
  luaotfload      `
  luatex          `
  luatex85        `
  luatexbase      `
  luatexja        `
  metafont        `
  mfware          `
  ms              `
  oberdiek        `
  platex-tools    `
  preview         `
  psnfss          `
  tex             `
  tex-ini-files   `
  tools           `
  trimspaces      `
  ucharcat        `
  ulem            `
  unicode-data    `
  uplatex         `
  varwidth        `
  xcjk2uni        `
  xcolor          `
  xecjk           `
  xetex           `
  xkeyval         `
  xunicode        `
  zhmetrics       `
  zhmetrics-uptex `
  zhnumber

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
