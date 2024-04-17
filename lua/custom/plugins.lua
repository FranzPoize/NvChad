local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
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
    opts = overrides.mason
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
      require("better_escape").setup()
    end,
  },

  -- Vim fugitive
  {
    "tpope/vim-fugitive",
  },

  {
    'mfussenegger/nvim-dap',
  },

  {
    'nvim-neotest/nvim-nio',
  },

  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('~/.local/share/nvim/mason/bin/debugpy')
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require("dapui").setup()
    end,
  },

  {
    'stevearc/overseer.nvim',
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
    "folke/trouble.nvim",
    cmd = "Trouble",
    branch = "dev",
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
      'nvim-lua/plenary.nvim',
      "mfussenegger/nvim-dap",
      "LiadOz/nvim-dap-repl-highlights",
    }
  }

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
