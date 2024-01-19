-- vim.cmd("highlight UfoCustom" .. " guifg='#1174b1'") -- same Hop color
-- vim.cmd("highlight UfoCustom" .. " guifg='#1BFF00'") -- same Hop color
-- vim.cmd("highlight UfoCustom" .. " guifg='#1174b1'") -- same Hop color
vim.cmd("highlight UfoCustom" .. " guifg='#ff007c'") -- same Hop color
-- vim.api.nvim_set_hl(0, "UfoCustom", { link = "Visual" })

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (" 󰡏 %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "UfoCustom" })
  return newVirtText
end

local ok, ufo = pcall(require, "ufo")
if ok then
  ufo.setup {
    fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  }
end
