local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------
g.formatters_list = { "stylua" }
g.linters_list = { "mypy" }
g.mason_binaries_list = { "marksman", "pylsp", "vimls" }
g.ts_binaries_list = { "lua", "python", "vimdoc" }
g.highlighturl_enabled = true
g.diagnostic_mode = { virtual_text = false, signs = false, underline = false, update_in_insert = false }
g.diagnostic_mode_num = 1
g.python3_host_prog = "~/.local/lib/virtualvenvs/ds/bin/python"

-------------------------------------- options ------------------------------------------
opt.number = true         -- show numberline
opt.relativenumber = true -- show relative numberline
opt.swapfile = false
opt.wrap = false          -- disable wrapping of lines longer than the width of window
opt.writebackup = false   -- disable making a backup before overwriting a fileopt.writebackup = false   -- disable making a backup before overwriting a file
