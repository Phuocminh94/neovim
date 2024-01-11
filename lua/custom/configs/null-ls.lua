local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local linting = null_ls.builtins.diagnostics

local sources = {}

if #vim.g.formatters_list > 0 then
  for _, fmt in pairs(vim.g.formatters_list) do
    table.insert(sources, formatting[fmt])
  end
end

if #vim.g.linters_list > 0 then
  for _, lint in pairs(vim.g.linters_list) do
    table.insert(sources, linting[lint])
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
}
