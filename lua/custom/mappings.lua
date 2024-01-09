local opts = { silent = true }

return {
  general = {
    n = {
      -- swap lines
      ["<A-j>"] = { ":m .+1<CR>==", "Swap below", opts = opts },
      ["<A-k>"] = { ":m .-2<CR>==", "Swap above", opts = opts },

      -- open link in defaukt browser
      ["gx"] = { "<cmd>silent !xdg-open <cfile><CR>", "Open link in browser" },

      -- resize windows
      ["<C-Up>"] = { "<cmd>resize -2<CR>", "Resize up" },
      ["<C-Down>"] = { "<cmd>resize +2<CR>", "Resize down" },
      ["<C-Left>"] = { "<cmd>vertical resize -2<CR>", "Resize left" },
      ["<C-Right>"] = { "<cmd>vertical resize +2<CR>", "Resize right" },

      -- auto recenter search
      -- NOTE: behavior of n/N depend on / or ?
      -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      ["n"] = { "nzz", "Recenter next search", cheatsheet = false, opts = { silent = true } },
      ["N"] = { "Nzz", "Recenter previous search", cheatsheet = false, opts = { silent = true } },

      -- clone VsCode style
      ["<A-S-k>"] = { "<cmd>t-1<CR>", "Copy line up" },
      ["<A-S-j>"] = { "<cmd>t.<CR>", "Copy line down" },

      -- quick fix
      ["]q"] = { "<cmd>cnext<CR>", "Next quickfix" },
      ["[q"] = { "<cmd>cprev<CR>", "Previous quickfix" },
      ["Q"] = { "<cmd>copen<CR>", "Open quickfix" },

      -- quit
      ["<leader>q"] = { "<cmd>confirm q<CR>", "Quit window" },
      ["<leader>Q"] = { "<cmd>confirm qall<CR>", "Quit all windows" },
    },

    i = {
      -- escape insert mode
      ["jk"] = { "<Esc>", "Escape insert mode" },
      ["JK"] = { "<Esc>", "Escape insert mode" },

      -- swap lines
      ["<A-j>"] = { "<Esc>:m .+1<CR>==gi", "Swap below" },
      ["<A-k>"] = { "<Esc>:m .-2<CR>==gi", "Swap above" },

      ["<C-f>"] = { "<C-o>de", "Delete till next word" },
    },

    v = {
      ["<A-S-j>"] = { "y'>:put<CR>`<gv", "Copy block down" },
      ["<A-S-k>"] = { "<cmd>t-1<CR>", "Copy block up" },
      ["<A-j>"] = { ":m '>+1<CR>gv-gv", "Visual swap below" },
      ["<A-k>"] = { ":m '<-2<CR>gv-gv", "Visual swap above" },
      ["<leader>s"] = { ":sort<CR>", "Sort lines" },
      ["d"] = { '"_d', "Delete char without yank" },
    },
  },

  multicursor = {
    n = {
      ["<C-M-j>"] = { "<Plug>(VM-Add-Cursor-Down)", "Multicursor down" },
      ["<C-M-k>"] = { "<Plug>(VM-Add-Cursor-Up)", "Multicursor up" },

      ["\\\\a"] = { "<Plug>(VM-Select-All)", "Multicursor All" },
      ["\\\\A"] = { "<Plug>(VM-Align)", "Multicursor Align" },

      ["\\\\d"] = { "<Plug>(VM-Duplicate)", "Multicursor duplicate" },
      ["\\\\y"] = { "<Plug>(VM-Yank)", "Multicursor Yank" },
    },
  },

  dapconfig = {
    n = {
      -- toggle breakpoint
      ["<leader>db"] = { "<cmd> lua require 'dap'.toggle_breakpoint() <CR>", "Toggle Breakpoint (F9)" },
      ["<F9>"] = { "<cmd> lua require 'dap'.toggle_breakpoint() <CR>", "Toggle Breakpoint (F9" },

      -- start/continue/stop/restart
      ["<leader>dc"] = { "<cmd> lua require 'dap'.continue() <CR>", "Start/Continue (F5)" },
      ["<F5>"] = { "<cmd> lua require 'dap'.continue() <CR>", "Start/Continue (F5)" },
      ["<F17>"] = {
        function()
          require("dap").terminate()
        end,
        "Stop",
      }, -- Shift+F5
      ["<leader>ds"] = {
        function()
          require("dap").terminate()
        end,
        "Stop (S-F5)",
      },
      ["<F29>"] = {
        function()
          require("dap").restart_frame()
        end,
        "Restart",
      }, -- Control+F5
      ["<leader>dr"] = {
        function()
          require("dap").restart_frame()
        end,
        "Restart",
      },

      -- step into/over/out
      ["<leader>di"] = { "<cmd> lua require 'dap'.step_into() <CR>", "Step Into (F11)" },
      ["<F11>"] = {
        function()
          require("dap").step_into()
        end,
        "Step Into",
      },

      ["<leader>do"] = { "<cmd> lua require 'dap'.step_over() <CR>", "Step Over (F10)" },
      ["<F10>"] = {
        function()
          require("dap").step_over()
        end,
        "Step Over",
      },

      ["<leader>dO"] = { "<cmd> lua require 'dap'.step_out() <CR>", "Step Out (Shift + F11)" },
      ["<F23>"] = {
        function()
          require("dap").step_out()
        end,
        "Step Out",
      }, -- Shift+F11

      -- conditional breakpoint
      ["<leader>dC"] = {
        function()
          require("dap").set_breakpoint(vim.fn.input "Condition: ")
        end,
        "Conditional Breakpoint (S-F9)",
      },
      ["<F21>"] = { -- Shift+F9
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then
              require("dap").set_breakpoint(condition)
            end
          end)
        end,
        "Conditional Breakpoint",
      },

      ["<leader>dq"] = {
        function()
          require("dap").close()
        end,
        "Close Session",
      },
      ["<leader>dp"] = {
        function()
          require("dap").pause()
        end,
        "Pause (F6)",
      },
      ["<F6>"] = {
        function()
          require("dap").pause()
        end,
        "Pause",
      },
      ["<leader>dt"] = {
        function()
          require("dap").run_to_cursor()
        end,
        "Run To Cursor",
      },

      ["<leader>dE"] = {
        function()
          vim.ui.input({ prompt = "Expression: " }, function(expr)
            if expr then
              require("dapui").eval(expr, { enter = true })
            end
          end)
        end,
        "Evaluate Input",
      },
      ["<leader>du"] = {
        function()
          require("dapui").toggle()
        end,
        "Toggle Debugger UI",
      },
      ["<leader>dh"] = {
        function()
          require("dap.ui.widgets").hover()
        end,
        "Debugger Hover",
      },
    },
  },

  ["ui/ux"] = {
    n = {
      ["<leader>id"] = { [[ <cmd> lua require "custom.ui".set_indent() <CR> ]], "Set indent" },
      ["<leader>uh"] = { [[ <cmd> lua require "custom.ui".toggle_buffer_syntax() <CR> ]], "Toggle syntax highlight" },
      ["<leader>ul"] = { [[ <cmd> lua require "custom.ui".toggle_url_match() <CR> ]], "Toggle URL highlight" },
      ["<leader>un"] = { [[ <cmd> lua require "custom.ui".change_number() <CR> ]], "Change number mode" },
      ["<leader>up"] = { [[ <cmd> lua require "custom.ui".toggle_autopairs() <CR> ]], "Toggle autopairs" },
      ["<leader>uw"] = { [[ <cmd> lua require "custom.ui".toggle_wrap() <CR> ]], "Toggle wrap" },
      ["<leader>ud"] = { [[ <cmd> lua require "custom.ui".change_diagnostic_mode() <CR> ]], "Change diagnostic mode" },
    },
  },

  REPL = {
    n = {
      ["<leader>st"] = { "<cmd> lua require 'iron.core'.send_until_cursor() <CR>", "Send till cursor" },
      ["<leader>so"] = { "<cmd> IronRepl <CR>", "Open/Close" },
      ["<leader>ss"] = { "<cmd> IronFocus <CR>", "Focus" },
      ["<leader>sf"] = { "<cmd> lua require 'iron.core'.send_file() <CR>", "Send all" },
      ["<leader>sr"] = { "<cmd> IronRestart <CR>", "Restart" },
      ["<leader>sl"] = { "<cmd> lua require 'iron.core'.send_line() <CR>", "Send line" },
    },

    v = {
      ["<leader>sv"] = { "<cmd> lua require 'iron.core'.visual_send() <CR>", "Send visual" },
    },

    x = {
      ["<leader>sv"] = { "<cmd> lua require 'iron.core'.visual_send() <CR>", "Send visual" },
    },
  },
}
