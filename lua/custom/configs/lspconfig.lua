local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
capabilities.offsetEncoding = {"utf-16"}

local lspconfig = require "lspconfig"

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
local servers = {  "html", "cssls", "clangd", "glslls", "ruff", "odoo_lsp"}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      pyright = {
        python = {
          analysis = {
            logLevel = "Trace"
          }
        }
      }
    }
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

local mason_registry = require('mason-registry')
local ts_language_server_path = mason_registry.get_package('typescript-language-server'):get_install_path() .. '/node_modules/typescript/lib'

lspconfig.volar.setup({
  filetypes = { "vue", "javascript", "typescript" }, -- Include Nuxt files
  init_options = {
    typescript = {
      tsdk = ts_language_server_path,
    },
    languageFeatures = {
      implementation = true,
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = true,
      rename = true,
      renameFileRefactoring = true,
      signatureHelp = true,
      codeAction = true,
      completion = {
        defaultTagNameCase = "both",
        getDocumentNameCasesRequest = true,
        getDocumentSelectionRequest = true
      },
    }
  }
})

-- 
-- lspconfig.pyright.setup { blabla}
