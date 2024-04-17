local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local utils = require "custom.utils"
local overseer = require "overseer"

-- our picker function: colors
local find_build_folder = function(opts)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = "Build",
        finder = finders.new_table {
          results = utils.find_make_files(),
          entry_maker = function(entry)
            return {
              value = entry[2],
              display = entry[1],
              ordinal = entry[2],
            }
          end,
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local task = overseer.new_task {
              cmd = "make",
              args = {"-j", "8"},
              cwd = selection["value"],
            }
            task:start()
            overseer:open()
          end)
          return true
        end,
      })
      :find()
end

local function display_telescope_dropdown()
  find_build_folder(require("telescope.themes").get_dropdown())
end

-- to execute the function
local M = {}

M.setup = function()
  vim.api.nvim_create_user_command("OpenBuildTasks", display_telescope_dropdown, {})
end

return M
