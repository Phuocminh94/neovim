local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {}

for _, fmt in pairs(vim.g.formatters_list) do
  table.insert(sources, formatting[fmt])
end

null_ls.setup {
  debug = true,
  sources = sources,
}
