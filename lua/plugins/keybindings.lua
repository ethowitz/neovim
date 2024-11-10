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
      -- { "<leader>w", group = "windows..." },
      { "<leader>f", group = "find..." },
    },
  },
  keys = {
    {
      "<leader><leader>",
      ":b#<CR>",
      desc = "go to last buffer",
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
    { "<leader>ci", ":e $MYVIMRC<CR>", desc = "open init.lua" },
    { "<leader>cp", ":e /Users/ethan/.config/nvim/lua/config/packer.lua<CR>", desc = "open plugins.lua" },
    { "<leader>q", ":copen<CR>", desc = "open quickfix list" },
    { "<leader>tc", ":tabclose<CR>", desc = "close the current tab" },
    { "<leader>tn", ":tabnew<CR>", desc = "create a new tab" },
    -- { "<leader>wc", ":close<CR>", desc = "close current window" },
    -- { "<leader>wh", ":sp<CR>", desc = "create a horizontal split" },
    -- { "<leader>wv", ":vsp<CR>", desc = "create a vertical split" },
    { "<C-p>", ":bprev<CR>", desc = "previous buffer" },
    { "<C-n>", ":bnext<CR>", desc = "next buffer" },
    { "<Esc>", ":noh<CR>", desc = "clear highlights" },
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
