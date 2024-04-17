local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "xml", "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  b.formatting.xmlformat.with { extra_args = {"--indent", "4", "--blanks"}},
  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- python
  b.formatting.isort,
  b.diagnostics.pylint,
  b.formatting.black,
  b.diagnostics.flake8
}

null_ls.setup {
  debug = false,
  sources = sources,
}
