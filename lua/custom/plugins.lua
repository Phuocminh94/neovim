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
    "ThePrimeagen/harpoon",
    keys = { "<leader>ma", "<leader>m", "<leader>mp", "<leader>mn" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- REQUIRED
      vim.keymap.set("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file() <CR>")
      vim.keymap.set("n", "<leader>ma", "<cmd>Telescope harpoon marks <CR>")
      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<leader>mp", "<cmd>lua require('harpoon.ui').nav_prev() <CR>")
      vim.keymap.set("n", "<leader>mn", "<cmd>lua require('harpoon.ui').nav_next() <CR>")
    end,
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

  {
    "folke/zen-mode.nvim",
    keys = { "<leader>z" },
    cmd = { "ZenMode" },
    config = function()
      vim.keymap.set("n", "<leader>z", ":ZenMode <CR>")
      require("zen-mode").setup {
        on_open = function(win)
          vim.cmd [[set laststatus=0]]
          vim.cmd [[set cmdheight=0]]
        end,
        on_close = function(win)
          vim.cmd [[set laststatus=3]]
          vim.cmd [[set cmdheight=1]]
        end,
      }
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    keys = { "zr", "zm", "[z", "]z" },
    event = { "BufRead" },
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require "custom.configs.ufo"
      vim.keymap.set("n", "[z", require("ufo").openAllFolds)
      vim.keymap.set("n", "]z", require("ufo").closeAllFolds)
      -- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      -- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAll
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    keys = { "<leader>o" },
    config = function()
      local opts = require "custom.configs.symbols-outline"
      require("symbols-outline").setup(opts)
      vim.keymap.set({ "n" }, "<leader>o", ":SymbolsOutline<CR>", { desc = "Symbols outline" })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
}
