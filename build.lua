#!/usr/bin/env texlua

-- Build script for zhlipsum.

module = "zhlipsum"

sourcefiledir = "./source"

sourcefiles  = {"*.dtx"}
installfiles = {"*.sty", "*.def"}
unpackfiles  = {"zhlipsum.dtx"}
gbkfiles     = {"zhlipsum-gbk.def"}
big5files    = {"zhlipsum-big5.def"}

unpackexe    = "xetex"
unpackopts   = "-file-line-error -halt-on-error -interaction=batchmode"

typesetfiles     = {"zhlipsum.dtx", "zhlipsum-en.tex"}
typesetsuppfiles = {"ctxdoc.cls"}
typesetexe       = "xelatex"
makeindexexe     = "zhmakeindex"

function docinit_hook(file)
  local cmd = "texlua" .. " "
           .. "../../scripts/get-doc-en.lua" .. " "
           .. typesetfiles[1] .. " "
           .. typesetfiles[2]
  run(typesetdir, cmd)
  return 0
end

stdengine       = "xetex"
checkengines    = {"pdftex", "xetex", "luatex"}
specialformats  = {}
specialformats.latex = {
  pdftex = {binary = "latex", options = "-output-format=dvi"},
  uptex  = {binary = "euptex"}
}

function zhconv(input, output, encoding)
  local input_tmp = input .. ".tmp"
  local cmd_cp    = "cp" .. " " .. input .. " " .. input_tmp
  local cmd_rm    = "rm" .. " " .. input_tmp
  local cmd_conv  = "iconv" .. " " .. "--from-code=UTF-8"
                            .. " " .. "--to-code=" .. encoding
                            .. " <" .. input_tmp
                            .. " >" .. output
  run(maindir, cmd_cp)
  run(maindir, cmd_conv)
  run(maindir, cmd_rm)
end

function hooked_bundleunpack(sourcedirs, sources)
  unhooked_bundleunpack(sourcedirs, sources)
  -- UTF-8 to GBK conversion
  for _, glob in ipairs(gbkfiles) do
    for _, f in ipairs(filelist(unpackdir, glob)) do
      local f_utf = unpackdir .. "/" .. f
      zhconv(f_utf, f_utf, "GBK")
    end
  end
  -- UTF-8 to Big5 conversion
  for _, glob in ipairs(big5files) do
    for _, f in ipairs(filelist(unpackdir, glob)) do
      local f_utf = unpackdir .. "/" .. f
      zhconv(f_utf, f_utf, "BIG-5")
    end
  end
end

function main(target, names)
  unhooked_bundleunpack = bundleunpack
  bundleunpack = hooked_bundleunpack
  stdmain(target, names)
end
