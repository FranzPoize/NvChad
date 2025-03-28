local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "xml", "html", "markdown", "css"} }, -- so prettier works only on these filetypes
  b.diagnostics.eslint_d.with { filetypes = { "js", "ts", "vue"} }, -- so prettier works only on these filetypes
  b.formatting.eslint_d.with { filetypes = { "js", "ts", "vue"} }, -- so prettier works only on these filetypes
  b.code_actions.eslint_d,

  b.formatting.xmlformat.with { extra_args = {"--indent", "4", "--blanks"}},
  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
}

null_ls.builtins.diagnostics.pylint.with({
  env = function(params)
    return { PYTHONPATH = vim.fn.expand(params.root .. "/.venv/lib/*/site-packages")}
  end
})

null_ls.setup {
  debug = false,
  sources = sources,
}
