local custom = vim.api.nvim_create_augroup("CustomAutocmd", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual" }
  end,
  group = custom,
})

-- Execute code
autocmd({ "FileType", "BufEnter" }, {
  desc = "Execute code file/block",
  pattern = { "*" },
  callback = function()
    if vim.bo.ft == "lua" then
      vim.cmd [[nnoremap <silent> <buffer> <leader><C-M> :so %<CR>]]
      -- vim.cmd [[vnoremap <silent> <buffer> <F5> :w so %<CR>]]
    elseif vim.bo.ft == "python" then
      vim.cmd [[nnoremap <silent> <buffer> <leader><C-M> : !python %<CR>]]
      vim.cmd [[vnoremap <silent> <buffer> <leader><C-M> :w !python <CR>]]
    elseif vim.bo.ft == "javascript" then
      vim.cmd [[nnoremap <silent> <buffer> <leader><C-M> : !node %<CR>]]
      vim.cmd [[vnoremap <silent> <buffer> <leader><C-M> :w !node <CR>]]
    elseif vim.bo.ft == "vim" then
      vim.cmd [[nnoremap <silent> <buffer> <leader><C-M> :so %<CR>]]
    end
  end,
  group = custom,
})

-- Quick escape with q
autocmd({ "FileType" }, {
  group = custom,
  pattern = {
    "Markdown",
    "checkhealth",
    "dap floats",
    "help",
    "lazy",
    "lspinfo",
    "man",
    "qf",
    "spectre_panel",
  },
  desc = "Quick escape with q",
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]]
  end,
})

-- Fix indent blankline
vim.g.refreshBlankline = true
autocmd(
  { "LspAttach" }, -- what if there is no lsp sever attach to this buffer.
  {                -- use BufRead, BufEnter, ... could defer the loading flow.
    pattern = { "*" },
    desc = "Refresh indent blankline on startup",
    callback = function()
      vim.defer_fn(function()
        if vim.g.refreshBlankline then
          vim.cmd [[IndentBlanklineRefresh]]
          vim.g.refreshBlankline = nil
        end
      end, 1)
    end,
    group = custom,
  }
)

-- Reload indent blankline on changes
vim.g.initialColorscheme = require("core.utils").load_config().ui.theme
vim.g.initialIndentBlank = require("core.utils").load_config().ui.blankline.blank
vim.g.initialIndentChar = require("core.utils").load_config().ui.blankline.style
autocmd({ "BufWritePost" }, {
  pattern = { "*" },
  desc = "Reload indent on theme changed",
  group = custom,
  callback = function()
    local current_blank = require("core.utils").load_config().ui.blankline.blank
    local current_char = require("core.utils").load_config().ui.blankline.style
    local current_color = require("core.utils").load_config().ui.theme
    if
        vim.g.initialColorscheme ~= current_color
        or vim.g.initialIndentBlank ~= current_blank
        or vim.g.initialIndentChar ~= current_char
    then
      require("plenary.reload").reload_module "plugins.configs.blankline"
      -- Defer the execution of the second line by 50 milliseconds
      vim.defer_fn(function()
        vim.cmd [[Lazy reload indent-blankline.nvim]]
        vim.cmd [[IndentBlanklineRefresh]]
      end, 50)
      vim.g.initialColorscheme = current_color
      vim.g.initialIndentChar = current_char
      vim.g.initialIndentBlank = current_blank
    end
  end,
})

-- Prevent custom.configs.section from loading null-ls on startup. The timing does matter.
vim.g.loadedFormatter = false
vim.g.loadedLinter = false
autocmd({ "BufRead" }, {
  pattern = { "*" },
  desc = "Prevent custom.configs.section from loading null-ls on startup",
  callback = function()
    vim.schedule(function()
      if not (vim.g.loadedFormatter and vim.g.loadedFormatter) then
        local ok, s = pcall(require, "null-ls.sources")
        if ok then
          vim.g.loadedFormatter = true
          vim.g.loadedLinter = true
        end
      end
    end)
  end,
})

-- Highlight URL
autocmd({ "VimEnter", "FileType", "BufEnter", "WinEnter" }, {
  desc = "URL Highlighting",
  group = custom,
  callback = function()
    -- Define HighlightURL highlight group
    vim.api.nvim_exec([[ hi def link HighlightURL Underlined ]], false)
    vim.cmd "highlight HighlightURL gui=underline,italic guifg=#1174b1"
    matchURL()
  end,
})
