return {
  {
    "psliwka/vim-smoothie",
    keys = { "<C-d>", "<C-u>" },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    keys = {
      "ys",
      "cs",
      "ds",
      "v",
      "V",
    },
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "ggandor/leap.nvim",
    keys = { "s", "vs", "gs", "vgs" },
    config = function()
      require("leap").add_default_mappings()
      require("leap").add_repeat_mappings(";", ",", {
        relative_directions = true,
        modes = { "n", "x", "o" },
      })
      -- vim.cmd("highlight LeapLabelPrimary" .. " guifg='#ff007c'")
      -- vim.cmd("highlight LeapLabelPrimary" .. " guifg='#1BFF00'")
      -- vim.cmd("highlight LeapLabelPrimary" .. " guifg='#1174b1'")
      vim.cmd("highlight LeapLabelPrimary" .. " guifg='#4AF626'" .. "guibg=" .. vim.g.mylightbg)
      -- vim.cmd("highlight LeapLabelPrimary" .. " guifg='#ff007c'" .. "guibg=" .. vim.g.mylightbg)
      -- vim.api.nvim_set_hl(0, "LeapLabelPrimary", { link = "Visual" })
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

  {
    "ahmedkhalf/project.nvim",
    enabled = false,
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
    keys = { "zr", "zm", "za", "zo", "[z", "]z" },
    event = { "BufRead" },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            setopt = true,       -- Whether to set the 'statuscolumn' option, may be set to false for those who
            relculright = false, -- whether to right-align the cursor line number with 'relativenumber' set
            -- Builtin 'statuscolumn' options
            ft_ignore = nil,     -- lua table with 'filetype' values for which 'statuscolumn' will be unset
            bt_ignore = nil,     -- lua table with 'buftype' values for which 'statuscolumn' will be unset
            segments = {
              -- https://github.com/askfiy/SimpleNvim/blob/master/lua/core/depends/statuscol/init.lua
              {
                sign = {
                  name = { "Dap*", "Diag*" },
                  namespace = { "bulb*", "gitsign*" },
                  colwidth = 1,
                },
                click = "v:lua.ScSa",
              },
              {
                text = { " ", builtin.lnumfunc },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScLa",
              },
              {
                text = { " ", builtin.foldfunc, "  " },
                condition = { true, builtin.not_empty },
                click = "v:lua.ScFa",
              },
            },
          }
        end,
      },
    },
    config = function()
      require "custom.configs.ufo"
      vim.keymap.set("n", "zj", "<cmd>lua next_closed_fold('j') <CR>", { desc = "Previous closed fold" })
      vim.keymap.set("n", "zk", "<cmd>lua next_closed_fold('k') <CR>", { desc = "Next closed fold" })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    enabled = false,
    keys = { "<leader>o" },
    config = function()
      local opts = require "custom.configs.symbols-outline"
      require("symbols-outline").setup(opts)
      vim.keymap.set({ "n" }, "<leader>o", ":SymbolsOutline<CR>", { desc = "Symbols outline" })
    end,
  },

  {
    "hedyhli/outline.nvim",
    keys = { "<leader>o" },
    opts = function()
      return require "custom.configs.outline"
    end,
    config = function(_, opts)
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
      vim.api.nvim_set_hl(0, "OutlineCurrent", { link = "Visual" })

      require("outline").setup(opts)
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

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    enabled = false,
    event = "LspAttach",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      show_dirname = true,
      show_basename = true,
    },
  },

  {
    "Wansmer/treesj",
    config = function()
      require("treesj").setup {}
    end,
  },

  {
    "olimorris/persisted.nvim",
    cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionStop",
      "SessionSave",
      "SessionLoad",
      "SessionLoadLast",
      "SessionDelete",
    },
    config = function()
      require("persisted").setup {
        should_autosave = function()
          -- do not autosave if the alpha dashboard is the current filetype
          if vim.bo.filetype == "nvdash" then
            return false
          end
          return true
        end,
      }
    end,
  },

  {
    "Pocco81/true-zen.nvim",
    cmd = { "TZAtaraxis" },
    keys = { "<leader>z" },
    config = function()
      require("true-zen").setup {}
      vim.keymap.set("n", "<leader>z", "<cmd>TZMinimalist<CR>", { desc = "Zen mode" })
    end,
  },

  {
    "max397574/better-escape.nvim",
    keys = { "jj", "jk" },
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "jj" }, -- a table with mappings to use
      }
    end,
  },

  {
    "chentoast/marks.nvim",
    enabled = true,
    keys = { "'", "`", "m", "<leader>bm" },
    config = function()
      vim.cmd("highlight MarkSignNumHL" .. " guifg='#ff007c'")
      require("marks").setup ({})
    end,
  },

  {
    "rmagatti/goto-preview",
    enabled = true,
    event = "LspAttach",
    config = function()
      require("goto-preview").setup {
        default_mappings = true,
      }
    end,
  },
}
