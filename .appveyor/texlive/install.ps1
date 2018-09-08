Get-ChildItem
Invoke-WebRequest -Uri "https://mirrors.rit.edu/CTAN/systems/texlive/tlnet/install-tl.zip" `
                  -OutFile "install-tl.zip"
Expand-Archive "install-tl.zip" -DestinationPath .
Set-Location "install-tl-20*"

.\install-tl-advanced.bat -no-gui `
                          -profile     ../.appveyor/texlive/texlive.profile `
                          -repository  https://mirrors.rit.edu/CTAN/systems/texlive/tlnet

Write-Output $env:PATH
Write-Output $env:PROGRAMFILES
Write-Output $env:USERPROFILE

Get-ChildItem $env:PROGRAMFILES
Get-ChildItem $env:USERPROFILE
