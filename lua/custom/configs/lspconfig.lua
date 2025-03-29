local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
capabilities.offsetEncoding = {"utf-16"}

local lspconfig = require "lspconfig"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

local configs = require "lspconfig.configs"
configs.odoo_lsp = {
  default_config = {
    name = 'odoo-lsp',
    cmd = {'odoo-lsp'},
    filetypes = {'javascript', 'xml', 'python'},
    root_dir = require('lspconfig.util').root_pattern('.odoo_lsp', '.odoo_lsp.json')
  }
}


-- if you just want default config for the servers then put them in a table
local servers = {  "html", "cssls", "clangd", "glslls", "ruff", "odoo_lsp", "ts_ls", "eslint"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('lspconfig').pyright.setup {
  settings = {
    pyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        -- Ignore all files for analysis to exclusively use Ruff for linting
        ignore = { '*' },
      },
    },
  },
}

vim.cmd([[
autocmd! BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp,*.rgen,*.rmiss,*.rchit,*.rahit,*.rint,*.rcall set filetype=glsl
]])

vim.filetype.add({
  extension = {
    frag = "frag",
    vert = "vert",
  }
})

