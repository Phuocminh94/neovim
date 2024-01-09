return {
  {
    "psliwka/vim-smoothie",
    keys = { "<C-d>", "<C-u>" },
  },

  {
    "tpope/vim-surround",
    keys = {
      "v" --[[ visual mode ]],
      "ys",
      "cs",
      "ds",
    },
    dependencies = { "tpope/vim-repeat" },
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "vs", "gs", "vgs" },
    config = function()
      require("leap").add_default_mappings()
      -- vim.cmd("highlight LeapLabelPrimary" .. " guifg='#ff007c'")
      vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "Visual" })
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-backward-to)") -- remap the confusing S backward
    end,
  },

  {
    "sam4llis/nvim-lua-gf",
    keys = { "gf" },
  },

  {
    "mg979/vim-visual-multi",
    event = "BufRead",
    init = function()
      -- vim.cmd("highlight VisualMulti" .. " guibg='#ff007c'" .. " guifg='#ffffff'") -- same Hop color
      vim.api.nvim_set_hl(0, "VisualMulti", { link = "Visual" })
      vim.cmd [[let g:VM_default_mappings = 0]]
      vim.cmd [[let g:VM_Mono_hl = "VisualMulti"]]
      vim.cmd [[let g:VM_Extend_hl = "VisualMulti"]]
      vim.cmd [[let g:VM_Cursor_hl = "VisualMulti"]]
      vim.cmd [[let g:VM_mouse_mappings = 1]]
      vim.cmd [[let g:VM_leader = '\\\\']]
    end,
  },

  {
    "mfussenegger/nvim-dap",
    cmd = { "DapToggleBreakpoint", "DapContinue" },
    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",

      -- Installs the debug adapters
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require "custom.configs.dapconfig"
    end,
  },

  {
    "hkupty/iron.nvim",
    cmd = { "IronRepl", "IronRestart", "IronFocus", "IronHide" },
    opts = function()
      return require "custom.configs.iron"
    end,
    config = function(_, opts)
      local iron = require "iron.core"
      iron.setup(opts)
    end,
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "LspAttach",
    config = function()
      require("rainbow-delimiters.setup").setup {}
    end,
  },

  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = { "<leader>u" },
    config = function()
      vim.keymap.set({ "i", "n", "v" }, "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undotree" })
    end,
  },
}
