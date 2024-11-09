local config_dir = vim.api.nvim_call_function("stdpath", { "config" })

return {
  "folke/which-key.nvim",
  opts = {
    delay = 300,
    icons = {
      mappings = true,
      keys = {}, -- Defaults icons to those from the nerd font
    },
    spec = {
      { "<leader>b", group = "buffers..." },
      { "<leader>l", group = "lsp..." },
      { "<leader>g", group = "git..." },
      { "<leader>t", group = "tabs..." },
      { "<leader>w", group = "windows..." },
      { "<leader>f", group = "find..." },
    },
  },
  keys = {
    { "<leader>d",  ":Telescope cder<CR>",                                    desc = "change directory" },
    {
      "<leader>-",
      ":Oil<CR>",
      desc = "open directory explorer",
    },
    {
      "<leader>/",
      ":Telescope live_grep<CR>",
      desc = "live grep in current directory",
    },
    {
      "<leader><leader>",
      ":b#<CR>",
      desc = "go to last buffer",
    },
    {
      "<leader><space>",
      ":Telescope find_files<CR>",
      desc = "find file in current directory",
    },
    {
      "<leader>Q",
      ":cclose<CR>",
      desc = "close quickfix list",
    },
    {
      "<leader>bD",
      ":bufdo bwipeout<CR>",
      desc = "destroy all buffers",
    },
    {
      "<leader>bd",
      ":bd<CR>",
      desc = "destroy current buffer",
    },
    {
      "<leader>be",
      "%bd|e#<CR>",
      desc = "destroy all except current buffer",
    },
    {
      "<leader>cf",
      function()
        require("telescope.builtin").find_files({ cwd = config_dir })
      end,
      desc = "find config file",
    },
    { '<C-a>',      ':ToggleTerm<CR>',                                        desc = 'toggle terminal', mode = { 't', 'n' } },
    { "<leader>ci", ":e $MYVIMRC<CR>",                                        desc = "open init.lua" },
    { "<leader>cp", ":e /Users/ethan/.config/nvim/lua/config/packer.lua<CR>", desc = "open plugins.lua" },
    {
      "<leader>fd/",
      function()
        local dir = vim.fn.input("Directory: ", "", "file")
        require("telescope.builtin").live_grep({ search_dirs = { dir } })
      end,
      desc = "live grep in specific directory",
    },
    {
      "<leader>fd<space>",
      function()
        local dir = vim.fn.input("Directory: ", "", "file")
        require("telescope.builtin").find_files({ search_dirs = { dir } })
      end,
      desc = "find file in specific directory",
    },
    { "<leader>fgc", ":Telescope git_commits<CR>",                   desc = "search commit history" },
    { "<leader>fgh", ":Telescope git_bcommits<CR>",                  desc = "search commit history for this buffer" },
    { "<leader>fh",  ":Telescope help_tags<CR>",                     desc = "search neovim help tags" },

    { "<leader>fr",  ":Telescope lsp_references<CR>",                desc = "find references to symbol at cursor" },
    { "<leader>ft",  ":Telescope lsp_dynamic_workspace_symbols<CR>", desc = "find LSP types" },

    { "<leader>fu",  ":Telescope builtin<CR>",                       desc = "search other available telescope searches" },
    { "<leader>gB",  ":Gitsigns toggle_current_line_blame<CR>",      desc = "toggle current line blame" },
    { "<leader>gD",  ":DiffviewOpen<CR>",                            desc = "git diff project" },
    { "<leader>gR",  ":Gitsigns reset_buffer<CR>",                   desc = "reset buffer" },
    { "<leader>gb",  ":Git blame<CR>",                               desc = "blame this buffer" },
    { "<leader>gd",  ":Gitsigns diffthis<CR>",                       desc = "git diff hunk under cursor" },
    { "<leader>ghb", ":DiffviewFileHistory<CR>",                     desc = "git history for current branch" },
    { "<leader>ghf", ":DiffviewFileHistory %<CR>",                   desc = "git history for current file" },
    {
      "<leader>gl",
      function()
        require('gitlinker').get_buf_range_url('n')
      end,
      desc = "yank github permalink for this line"
    },
    { "<leader>gm", ":Git mergetool<CR>",         desc = "populate quickfix with merge conflicts" },
    { "<leader>gp", ":Gitsigns preview_hunk<CR>", desc = "preview hunk" },
    { "<leader>gr", ":Gitsigns reset_hunk<CR>",   desc = "reset hunk" },
    {
      "<leader>lq",
      function()
        vim.diagnostic.setqflist({ severity = { min = vim.diagnostic.severity.WARN } })
      end,
      mode = "v",
      desc = "dump LSP diagnostics to quickfix list",
    },
    { "<leader>lr", ":LspRestart<CR>",      desc = "restart LSP" },
    { "<leader>ls", ":LspStop<CR>",         desc = "stop LSP" },
    { "<leader>lg", ":LspStart<CR>",        desc = "start LSP" },
    { "<leader>m",  ":Telescope marks<CR>", desc = "search marks" },
    { "<leader>q",  ":copen<CR>",           desc = "open quickfix list" },
    { "<leader>tc", ":tabclose<CR>",        desc = "close the current tab" },
    { "<leader>tn", ":tabnew<CR>",          desc = "create a new tab" },
    { "<leader>wc", ":close<CR>",           desc = "close current window" },
    { "<leader>wh", ":sp<CR>",              desc = "create a horizontal split" },
    { "<leader>wv", ":vsp<CR>",             desc = "create a vertical split" },
    {
      "<leader>x",
      function()
        require("telescope.builtin").diagnostics({ severity_limit = vim.diagnostic.severity.WARN })
      end,
      desc = "search workspace-wide diagnostics",
    },
    { "<Esc>", ":noh<CR>", desc = "clear highlights" },
    {
      ",",
      function()
        require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
      end,
      desc = "search oldfiles",
    },
    {
      "<C-p>",
      function()
        require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
      end,
      desc = "search oldfiles",
    },
    {
      "<C-n>",
      function()
        require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
      end,
      desc = "search oldfiles",
    },
    {
      "[q",
      ":cp<CR>",
      desc = "go to previous quickfix item",
    },
    {
      "]q",
      ":cn<CR>",
      desc = "go to next quickfix item",
    },
  },
}
