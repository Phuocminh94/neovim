local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local linting = null_ls.builtins.diagnostics

local sources = {}

for _, fmt in pairs(vim.g.formatters_list) do
  table.insert(sources, formatting[fmt])
end

for _, lint in pairs(vim.g.linters_list) do
  table.insert(sources, linting[lint])
end

null_ls.setup {
  debug = true,
  sources = sources,
}
