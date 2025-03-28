---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-p>"] = { "<cmd> lua require('telescope.builtin').find_files{no_ignore}<CR>", "Find files" },
    ["<C-t>"] = { "<cmd> Telescope live_grep_args <CR>", "Live grep" },
    ["<C-m>"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
  i = {
    ["kj"] = { "<esc>", "Quit normal mode" },
  }
}

M.lspconfig =  {
  n = {
    ["rn"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch header source file" },
  }
}

M.overseer = {
  n = {
    ["<leader>ot"] = { "<cmd>OverseerToggle<cr>", "Open tasks"}
  }
}

-- more keybinds!

return M
