---@type ChadrcConfig
local M = {}

M.ui = {
  blankline = { style = "rainbow", blank = true }, -- style: rainbow/nil, blank = true/false
  cmp = { style = "atom" },
  extended_integrations = { "dap", "rainbowdelimiters", "trouble", "todo" },
  hl_override = {
    CursorLineNr = { fg = "yellow" },
    FoldColumn = { bg = "none", fg = "lightbg" },
    LspReferenceRead = { bg = "lightbg", fg = "none" },
    LspReferenceText = { bg = "lightbg", fg = "none" }, -- same Visual highlight but lighter
    LspReferenceWrite = { bg = "lightbg", fg = "none" },
  },

  statusline = {
    theme = "vscode",
    overriden_modules = function(modules)
      local custom = require "custom.configs.statusline"
      modules[1] = custom.mode()
      modules[2] = custom.fileInfo()
      modules[4] = custom.LSP_Diagnostics()
      modules[9] = custom.LSP_status()
      modules[10] = custom.tabWidth()
      modules[11] = custom.cursorPos()
      modules[12] = ""
      modules[13] = custom.cwd()
      table.insert(modules, 6, custom.others())
    end,
  },
  theme = "gruvchad",
  nvdash = {
    buttons = {
      { "  Find Files", "f", "Telescope find_files" },
      { "󱦺  Recent Files", "o", "Telescope oldfiles" },
      { "  Find Text", "w", "Telescope live_grep_args" },
      { "  Bookmarks", "b", "Telescope marks" },
      { "  Themes", "t", "Telescope themes" },
      { "  Projects", "p", "Telescope project" },
      { "󰒲  Lazy", "l", "Lazy" },
      { "  Exit", "q", "q" },
    },
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
