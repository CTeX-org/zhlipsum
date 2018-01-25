#!/usr/bin/env texlua

-- Build script for zhlipsum.

module = "zhlipsum"

sourcefiles = {"source/zhlipsum.dtx"}
installfiles = {"*.sty", "*.def"}

stdengine    = "xetex"
checkengines = {"xetex"}

-- Need to change the encodings.
unpackexe   = "xetex"
unpackfiles = {"zhlipsum.dtx"}

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
