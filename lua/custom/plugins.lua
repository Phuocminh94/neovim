return {
  {
    "psliwka/vim-smoothie",
    keys = { "<C-d>", "<C-u>" },
  },

  {
    "tpope/vim-surround",
    keys = { "v" --[[ visual mode ]], "ys", "cs", "ds" },
    dependencies = { "tpope/vim-repeat" },
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "vs", "gs", "vgs" },
    config = function()
      require('leap').add_default_mappings()
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-backward-to)") -- remap the confusing S backward
    end
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
}
