local opts = function()
  --- basic f, t, F, T
  vim.keymap.set("", "f", function()
    local directions = require("hop.hint").HintDirection
    require("hop").hint_char1 {
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
    }
  end, { remap = true, silent = true })

  vim.keymap.set("", "F", function()
    local directions = require("hop.hint").HintDirection
    require("hop").hint_char1 {
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
    }
  end, { remap = true, silent = true })

  vim.keymap.set("", "t", function()
    local directions = require("hop.hint").HintDirection
    require("hop").hint_char1 {
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
      hint_offset = -1,
    }
  end, { remap = true, silent = true })

  vim.keymap.set("", "T", function()
    local directions = require("hop.hint").HintDirection
    require("hop").hint_char1 {
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
      hint_offset = 1,
    }
  end, { remap = true, silent = true })

  --
  vim.api.nvim_set_keymap("n", "gs", ":HopChar1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>yy", ":HopYankChar1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<leader>pp", ":HopPasteChar1<CR>", { silent = true })

  require("hop").setup {
    keys = "etovxqpdygfblzhckisuran",
  }
end

return opts
