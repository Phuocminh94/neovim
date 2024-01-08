---@type ChadrcConfig
local M = {}

M.ui = {
  blankline = { style = "rainbow", blank = true }, -- style: rainbow/nil, blank = true/false
  hl_override = {
    CursorLineNr = { fg = "yellow" },
    LspReferenceRead = { bg = "lightbg", fg = "none" },
    LspReferenceText = { bg = "lightbg", fg = "none" }, -- same Visual highlight but lighter
    LspReferenceWrite = { bg = "lightbg", fg = "none" },
  },
  statusline = { theme = "vscode" },
  theme = "gruvchad",
}

M.plugins = "custom.plugins"

return M
