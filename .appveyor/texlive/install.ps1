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
