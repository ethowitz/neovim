return {
  ----------------------------------- GIT -------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        require("which-key").add({
          {
            "[g",
            function()
              gs.prev_hunk()
            end,
            desc = "prev hunk",
          },
          {
            "]g",
            function()
              gs.next_hunk()
            end,
            desc = "next hunk",
          },
        }, { buffer = bufnr })
      end,
    },
  },
  "tpope/vim-fugitive",
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  ------------------------------------ UI -------------------------------------
  "kyazdani42/nvim-web-devicons",
  {
    "stevearc/oil.nvim",
    opts = {},
  },
  { 'folke/todo-comments.nvim',               event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'akinsho/toggleterm.nvim',
    opts = {
      hide_numbers = false,
      shade_terminals = false,
      direction = 'tab',
      open_mapping = [[<c-\>]],
    },
  },

  ---------------------------------- TELESCOPE --------------------------------
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.6",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.7,
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
          color_devicons = true,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--hidden",
            "--glob",
            "!**/.git",
          },
        },
        pickers = {
          buffers = {
            layout_config = {
              height = 0.5,
            },
            previewer = false,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
          },
          jumplist = {
            mappings = {
              i = {
                ["<C-o>"] = actions.move_selection_previous,
                ["<C-i>"] = actions.move_selection_next,
              },
            },
            layout_config = {
              height = 0.9,
              width = 0.9,
              preview_height = 0.65,
            },
          },
          live_grep = {
            layout_strategy = "vertical",
            layout_config = {
              height = 0.9,
              width = 0.9,
            },
          },
          find_files = {
            previewer = false,
            find_command = {
              "fd",
              "--hidden",
              "--exclude",
              "**/.git",
              "--type",
              "file",
              "--type",
              "symlink",
              "--strip-cwd-prefix",
            },
          },
          diagnostics = {
            layout_strategy = "vertical",
          },
          lsp_references = {
            theme = "ivy",
            layout_strategy = "vertical",
            layout_config = {
              height = 0.9,
              width = 0.9,
            },
          },
        },
        extensions = {
          cder = {
            dir_command = { "fd", "--max-depth=4", "--type=d", ".", vim.g.start_directory },
            entry_maker = function(line)
              return {
                value = line,
                display = function(entry)
                  return "  " .. line:gsub(vim.g.start_directory .. "/", ""), { { { 1, 3 }, "Directory" } }
                end,
                ordinal = line,
              }
            end,
            previewer_command = "eza "
                .. "-a "
                .. "--color=always "
                .. "-T "
                .. "--level=3 "
                .. "--icons "
                .. "--git-ignore "
                .. "--long "
                .. "--no-permissions "
                .. "--no-user "
                .. "--no-filesize "
                .. "--git "
                .. "--ignore-glob=.git",
          },
        },
      })

      telescope.load_extension("cder")
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  { "Zane-/cder.nvim" },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
    opts = {
      scoring = {
        recency_modifier = {
          [1] = { age = 240, value = 100 },   -- past 4 hours
          [2] = { age = 1440, value = 90 },   -- past day
          [3] = { age = 4320, value = 80 },   -- past 3 days
          [4] = { age = 10080, value = 60 },  -- past week
          [5] = { age = 43200, value = 50 },  -- past month
          [6] = { age = 129600, value = 10 }, -- past 90 days
        },
        -- how much the score of a recent item will be improved.
        boost_factor = 0.0001,
      },
      default = {
        disable = true,     -- disable any unkown pickers (recommended)
        use_cwd = true,     -- differentiate scoring for each picker based on cwd
        sorting = "recent", -- sorting: options: 'recent' and 'frecency'
      },
      pickers = {           -- allows you to overwrite the default settings for each picker
        find_files = {
          disable = false,
          sorting = "frecency",
        },
        ["cder#cder"] = {
          disable = false,
          use_cwd = false,
          sorting = "frecency",
        },
      },
    },
  },

  ----------------------------- MOVEMENT AND SYNTAX --------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "rust",
          "toml",
          "terraform",
          "python",
          "asm",
          "bash",
          "sql",
          "ruby",
          "typescript",
          "yaml",
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
        ident = { enable = true },
        -- rainbow = {
        --   enable = true,
        --   extended_mode = true,
        --   max_file_lines = nil,
        -- },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  "tpope/vim-sleuth", -- automatically set 'shiftwidth' and 'expandtab'
  -- {
  --   "kwkarlwang/bufjump.nvim",
  --   config = function()
  --     require("bufjump").setup({
  --       forward = "<C-n>",
  --       backward = "<C-p>",
  --     })
  --   end,
  -- },
}
