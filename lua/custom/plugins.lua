local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        default_mappings = false,
        mappings = {
          i = {
            k = {
              j = "<Esc>",
            }
          },
        },
      })
    end,
  },

  -- Vim fugitive
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>q",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>qX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "gr",
        "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>ql",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>qq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "sindrets/winshift.nvim",
    lazy = false,
    keys = {
      {"<C-W><C-M>", "<cmd>WinShift<cr>", desc = "Win shift mode"     },
      {"<C-M-h>", "<cmd>WinShift left<cr>", desc = "Win shift left"   },
      {"<C-M-j>", "<cmd>WinShift down<cr>", desc = "Win shift down"   },
      {"<C-M-k>", "<cmd>WinShift up<cr>", desc = "Win shift up"       },
      {"<C-M-l>", "<cmd>WinShift right<cr>", desc = "Win shift right" },
    }
  },

  {
    "puremourning/vimspector",
    lazy = false,

    -- stylua: ignore
    keys = {
      --{ "<leader>dB", ":call vimspector#ToggleBrekpoint()<cr>", desc = "Breakpoint Condition" },
      { "<leader>db", "<cmd>call vimspector#ToggleBreakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "<leader>da", "<cmd>call vimspector#Launch()<cr>", desc = "Launch" },
      { "<leader>dq", "<cmd>call vimspector#Reset()<cr>", desc = "Reset" },
      { "<F5>", "<cmd>call vimspector#Continue()<cr>", desc = "Continue" },
      -- { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      -- { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      -- { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      -- { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
      -- { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
      -- { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
      -- { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
      -- { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
      -- { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
      -- { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
      -- { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      -- { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
      -- { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
      -- { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local dap_icons = {
        PC = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        PCBP = { "󰁕 ", "DiagnosticHint", "DapStoppedLine" },
        BP = " ",
        BPCond = " ",
        BPDisabled = { " ", "DiagnosticError" },
        BPLog = ".>",
      }

      for name, sign in pairs(dap_icons) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "vimspector" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },

  {
    "nvim-neotest/nvim-nio",
  },

  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "~/.local/share/nvim/mason/bin/debugpy"
    end,
  },

  {
    "stevearc/overseer.nvim",
    lazy = false,
    config = function()
      require("overseer").setup()
    end,
  },

  {
    dir = "~/.config/nvim/lua/snac-tasks",
    cmd = "OpenBuildTasks",
    dependencies = {
      "telescope.nvim",
    },
    config = function()
      require("snac-tasks").setup()
    end,
  },

  {
    "b0o/blender.nvim",
    config = function()
      require("blender").setup()
    end,
    lazy = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "grapp-dev/nui-components.nvim",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "LiadOz/nvim-dap-repl-highlights",
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>ps", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>pc", "<cmd>VenvSelectCached<cr>" },
    },
    branch = "regexp"
  },
  {
    "mbbill/undotree",
    lazy = false,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end,
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Add current file to Harpoon" },
      { "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Show Harpoon list" },
      { "<C-j>", function() require("harpoon"):list():select(1) end, desc = "Go to file in slot 1" },
      { "<C-k>", function() require("harpoon"):list():select(2) end, desc = "Go to file in slot 2" },
      { "<C-l>", function() require("harpoon"):list():select(3) end, desc = "Go to file in slot 3" },
      { "<C-h>", function() require("harpoon"):list():select(4) end, desc = "Go to file in slot 4" },
      { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Go to prev file" },
      { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Go to next file" },
    }
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = {
      highlight = {
        before = "fg",
        keyword = "bg",
        pattern = [[.*<(KEYWORDS).*:]]
      },
      -- TODO: hhljk
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      search = {
        pattern = [[\b(KEYWORDS)(\(.*\))?:]],
      },
    },
    keys = {
      { "<leader>to", "<cmd>TodoTrouble<cr>", desc = "Opens Todo trouble"},
    }
  },

  {
    "lambdalisue/vim-suda",
    cmd = {"SudaRead", "SudaWrite"}
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
