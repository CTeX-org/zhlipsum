#!/usr/bin/env sh

MIKTEX_DMG=miktex-2.9.6800-1-darwin-x86_64

wget https://mirrors.rit.edu/CTAN/systems/win32/miktex/setup/darwin-x86_64/$MIKTEX_DMG.dmg
sudo hdiutil attach $MIKTEX_DMG.dmg

ls -al /Volumes/
ls -al /Volumes/$MIKTEX_DMG/
man installer

sudo installer -package /Volumes/$MIKTEX_DMG/$MIKTEX_DMG.pkg -target /tmp/miktex

ls -al /tmp/
ls -al /tmp/miktex/

sudo hdiutil detach /Volumes/$MIKTEX_DMG
