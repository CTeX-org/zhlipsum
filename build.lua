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

function modified_check(names)
  local errorlevel = 0
  if testfiledir ~= "" and direxists(testfiledir) then
    if not options["rerun"] then
      checkinit()
    end
    local hide = true
    --[[
    -- To suppress TeX output.
    if names and next(names) then
      hide = false
    end
    ]]--
    names = names or { }
    -- No names passed: find all test files
    if not next(names) then
      for _,i in pairs(filelist(testfiledir, "*" .. lvtext)) do
        insert(names, jobname(i))
      end
      for _,i in ipairs(filelist(unpackdir, "*" .. lvtext)) do
        if fileexists(testfiledir .. "/" .. i) then
          print("Duplicate test file: " .. i)
          return 1
        else
          insert(names, jobname(i))
        end
      end
      sort(names)
      -- Deal limiting range of names
      if options["first"] then
        local allnames = names
        local active = false
        local firstname = options["first"]
        names = { }
        for _,name in ipairs(allnames) do
          if name == firstname then
            active = true
          end
          if active then
            insert(names,name)
          end
        end
      end
      if options["last"] then
        local allnames = names
        local lastname = options["last"]
        names = { }
        for _,name in ipairs(allnames) do
          insert(names,name)
          if name == lastname then
            break
          end
        end
      end
    end
    -- https://stackoverflow.com/a/32167188
    local function shuffle(tbl)
      local len, random = #tbl, rnd
      for i = len, 2, -1 do
          local j = random(1, i)
          tbl[i], tbl[j] = tbl[j], tbl[i]
      end
      return tbl
    end
    if options["shuffle"] then
      names = shuffle(names)
    end
    -- Actually run the tests
    print("Running checks on")
    local i = 0
    for _,name in ipairs(names) do
      i = i + 1
      print("  " .. name .. " (" ..  i.. "/" .. #names ..")")
      local errlevel = runcheck(name, hide)
      -- Return value must be 1 not errlevel
      if errlevel ~= 0 then
        if options["halt-on-error"] then
          return 1
        else
          errorlevel = 1
          -- visually show that something has failed
          print("          --> failed\n")
        end
      end
    end
    if errorlevel ~= 0 then
      checkdiff()
    else
      print("\n  All checks passed\n")
    end
  end
  return errorlevel
end

function main(target, names)
  unhooked_bundleunpack = bundleunpack
  bundleunpack = hooked_bundleunpack
  check = modified_check
  stdmain(target, names)
end

kpse.set_program_name("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
