local config = {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      theme = "tokyonight-storm",
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        -- {
        --   "filetype",
        --   colored = true,
        --   icon_only = true,
        -- },
        {
          "filename",
          path = 1,
          symbols = {
            modified = " ", -- Text to show when the file is modified.
            readonly = " ", -- Text to show when the file is non-modifiable or readonly.
            unnamed = "",
            newfile = " ", -- Text to show for newly created file before first write
          },
        },
      },
      lualine_x = {
        {
          function()
            return require("lsp-progress").progress()
          end,
        },
        {
          "diagnostics",
          sources = { "nvim_workspace_diagnostic" },
          sections = { "error", "warn" },
          symbols = { error = "  ", warn = "  ", info = "󰋼 ", hint = "󰌵 " },
          colored = true,
          update_in_insert = false,
          padding = { right = 0 },
        },
        {
          "location",
          padding_left = 0,
        },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
  },
}

return config
