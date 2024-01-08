local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------
g.mason_binaries_list = {"marksman", "pyright", "vimls"}
g.ts_binaries_list = {"lua", "python", "vimdoc"}
g.formatters_list = {"black"}

-------------------------------------- options ------------------------------------------
opt.number = true -- show numberline
opt.relativenumber = true -- show relative numberline
opt.swapfile = false
