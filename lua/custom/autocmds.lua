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

-- Press dd in qflist to remove an item
autocmd({ "FileType" }, {
  group = custom,
  pattern = { "qf" },
  desc = "Remove quickfix item when press dd",
  callback = function()
    function _G.removeQFItem()
      local curqfidx = vim.fn.line "." - 1
      local qfall = vim.fn.getqflist()
      table.remove(qfall, curqfidx + 1)
      vim.fn.setqflist(qfall, "r")
      vim.cmd(curqfidx + 1 .. "cfirst")
      vim.cmd ":copen"
    end

    vim.cmd "command! RemoveQFItem lua removeQFItem()"
    vim.api.nvim_buf_set_keymap(0, "n", "dd", "<cmd> RemoveQFItem <CR>", { silent = true })
  end,
})

-- Remove statusline on startup
vim.g.hasBufName = false
vim.g.autocmdEnabled = true
autocmd({ "BufRead", "FileType" }, {
  pattern = { "*" },
  desc = "Remove statusline on startup",
  callback = function()
    if vim.g.autocmdEnabled then
      if vim.g.hasBufName then
        vim.cmd [[set laststatus=3]]
        vim.g.autocmdEnabled = false
      else
        vim.cmd [[set laststatus=0]]
        vim.g.hasBufName = vim.api.nvim_buf_get_name(0) ~= "" and not vim.g.hasBufName or vim.g.hasBufName
      end
    end
  end,
})

-- Set short keymap for nvdash
autocmd({ "FileType" }, {
  pattern = { "nvdash" },
  desc = "Set Nvdash short keybinds",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "f", "<cmd> Telescope find_files <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "w", "<cmd> Telescope live_grep_args <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "o", "<cmd> Telescope oldfiles <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "b", "<cmd> Telescope marks <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "t", "<cmd> Telescope themes <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd> q! <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<cmd> Lazy <CR>", { silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "p", "<cmd> Telescope project <CR>", { silent = true })
  end,
  group = custom,
})

-- Restore save view
-- Taken from this https://github.com/askfiy/SimpleNvim/blob/master/lua/core/command/autocmd.lua
autocmd("BufReadPost", {
  pattern = { "*" },
  group = custom,
  desc = "return at where I was",
  callback = function()
    if vim.fn.line "'\"" > 0 and vim.fn.line "'\"" <= vim.fn.line "$" then
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fn.setpos(".", vim.fn.getpos "'\"")
      -- how do I center the buffer in a sane way??
      -- vim.cmd('normal zz')
      vim.cmd "silent! foldopen"
    end
  end,
})

autocmd("FileType", {
  pattern = {"nvcheatsheet"},
  group = custom,
  desc = "detach ufo on nvcheatsheet",
  callback = function ()
    vim.cmd [[lua require "ufo".detach()]]
  end
})

-- Detach ufo
-- autocmd({ "FileType" }, {
--   pattern = { "*" },
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, "n", "<F12>", ":lua pprint(vim.api.nvim_buf_get_name(0)) <CR>", { silent = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "<F11>", ":lua pprint(vim.bo.ft) <CR>", { silent = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "<F10>", ":lua pprint(vim.g.nvdash_displayed) <CR>", { silent = true })
--   end,
-- })
