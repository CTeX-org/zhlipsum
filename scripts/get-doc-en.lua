#!/usr/bin/env texlua

-- Generate the English version of the documentation.

local input_file_name  = arg[1]
local output_file_name = arg[2]

local file_banner = "%%\n"
                 .. "%% This is file `zhlipsum-en.tex',\n"
                 .. "%% generated with Lua script `get-doc-en.lua'.\n"
                 .. "%%\n"
                 .. "%% The original source files were:\n"
                 .. "%%\n"
                 .. "%% zhlipsum.dtx\n"

local tag_preamble_str    = "\\preamble"
local tag_endpreamble_str = "\\endpreamble"

local tag_driver_begin_str = "%<*driver>"
local tag_driver_end_str   = "%</driver>"

local tag_inline_str = "%^^A!"
local tag_begin_str  = "%^^A+"
local tag_end_str    = "%^^A-"
local tag_str_len    = string.len(tag_inline_str)

local function test_tag(str, tag)
    if string.sub(str, 1, string.len(tag)) == tag then
        return true
    end
    return false
end

local function remove_normal_space(str)
    -- Normal text lines begin with 2 spaces.
    -- `3` is the first non-space char's position.
    return string.sub(str, 3)
end

local function process_preamble_line(str)
    return "%% " .. str
end

local function process_verbatim_line(str)
    return remove_normal_space(str)
end

local function process_normal_line(str)
    return string.sub(str, tag_str_len + 2)
end

----------------------
-- Begin processing --
----------------------

input_file  = io.open(input_file_name,  "r")
output_file = io.open(output_file_name, "w")

-- Test whether it's in the preamble.
preamble_flag = 0

-- Test whether it's in the driver part.
driver_flag = 0

-- Test whether it's in the verbatim environment.
inside_flag = 0

output_file:write(file_banner)

for line in input_file:lines() do
    -- Check for the preamble, as DocStrip does.
    if test_tag(line, tag_preamble_str) then
        preamble_flag = preamble_flag + 1
    elseif test_tag(line, tag_endpreamble_str) then
        preamble_flag = preamble_flag - 1
    else
        -- Check if in the driver part.
        if test_tag(line, tag_driver_begin_str) then
            driver_flag = driver_flag + 1
        elseif test_tag(line, tag_driver_end_str) then
            driver_flag = driver_flag - 1
        else
            -- If beginning with `%^^A+` or `%^^A-`, then increase or
            -- decrease the flag, in order to determine the start or end
            -- position of verbatim.
            if test_tag(line, tag_begin_str) then
                inside_flag = inside_flag + 1
            elseif test_tag(line, tag_end_str) then
                inside_flag = inside_flag - 1
            else
                if preamble_flag == 1 then
                    output_file:write(process_preamble_line(line), "\n")
                elseif driver_flag == 1 then
                    -- Inside <*driver> ... </driver>.
                    -- Similar to normal text but do not have `% ` at beginning.
                    if inside_flag == 1 then
                        output_file:write(line, "\n")
                    elseif test_tag(line, tag_inline_str) then
                        output_file:write(process_normal_line(line), "\n")
                    end
                elseif inside_flag == 1 then
                    -- If inside_flag = 1, then it's a verbatim environment.
                    output_file:write(process_verbatim_line(line), "\n")
                elseif test_tag(line, tag_inline_str) then
                    -- If beginning with `%^^A!`, then this line is normal text.
                    output_file:write(process_normal_line(line), "\n")
                end
            end
        end
    end
end

input_file:close()
output_file:close()
