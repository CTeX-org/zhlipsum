#!/usr/bin/env texlua

-- Build script for zhlipsum.

module = "zhlipsum"

checkengines = {"xetex", "luatex"}
checkopts    = "-interaction=batchmode"

sourcefiles  = {"source/*.dtx"}
installfiles = {"*.sty", "*.def"}

-- Need to change the encodings.
unpackfiles = {"zhlipsum.dtx"}
unpackexe   = "xetex"

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
