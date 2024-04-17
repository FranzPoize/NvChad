local scan = require "plenary.scandir"
local Path = require("plenary.path")

local M = {}

M.find_make_files = function ()
  local dirs = scan.scan_dir(vim.loop.cwd(), {only_dirs = true, depth = 1, search_pattern = "build-"})
  local result = {}
  for _, v in ipairs(dirs) do
    if Path:new(v .. "/Makefile"):exists() then
      local parts = Path:new(v):_split()
      local folder_data = {
        parts[#parts],
        v
      }
      table.insert(result, folder_data)
    end
  end
  return result
end

return M
