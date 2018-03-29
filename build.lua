#!/usr/bin/env texlua

-- Build script for zhlipsum.

module = "zhlipsum"

sourcefiledir = "./source"

sourcefiles  = {"*.dtx"}
installfiles = {"*.sty", "*.def"}
unpackfiles  = {"zhlipsum.dtx"}
gbkfiles     = {"zhlipsum-gbk.def"}
big5files    = {"zhlipsum-big5.def"}

checkengines = {"xetex", "luatex"}

unpackexe    = "xetex"

checkopts    = "-interaction=batchmode"
unpackopts   = "-interaction=batchmode"

function zhconv(input, output, encoding)
  local input_tmp = input .. ".tmp"
  local cmd_cp    = "cp" .. " " .. input .. " " .. input_tmp
  local cmd_rm    = "rm" .. " " .. input_tmp
  local cmd_conv  = "iconv" .. " " .. "--from-code=utf8"
                            .. " " .. "--to-code=" .. encoding
                            .. " " .. "--output=" .. output
                            .. " " .. input_tmp
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
      zhconv(f_utf, f_utf, "gbk")
    end
  end
  -- UTF-8 to Big5 conversion
  for _, glob in ipairs(big5files) do
    for _, f in ipairs(filelist(unpackdir, glob)) do
      local f_utf = unpackdir .. "/" .. f
      zhconv(f_utf, f_utf, "big5")
    end
  end
end

function main(target, names)
  unhooked_bundleunpack = bundleunpack
  bundleunpack = hooked_bundleunpack
  stdmain(target, names)
end

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
