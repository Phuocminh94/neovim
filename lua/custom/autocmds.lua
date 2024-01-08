local custom = vim.api.nvim_create_augroup("CustomAutocmd", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  pattern = "*",
  callback = function() vim.highlight.on_yank({ higroup = "Visual" }) end,
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
autocmd({ "LspAttach" }, -- what if there is no lsp sever attach to this buffer.
  {                      -- use BufRead, BufEnter, ... could defer the loading flow.
    pattern = { "*" },
    desc = "Refresh indent blankline",
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
