---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<C-t>"] = { "<cmd> Telescope live_grep_args <CR>", "Live grep" },
    ["<C-m>"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>ta"] = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args{search_dirs={'.', 'odoo/external-src', 'odoo/src', 'odoo/src/addons', 'odoo/src/odoo/addons'}}<CR>", "Find buffers" },
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
