return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      light_style = "day",
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent", -- style for sidebars, see below
        floats = "transparent", -- style for floating windows
      },
      day_brightness = 0.1,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      colorblind = {
        enable = true,
        simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
        severity = {
          protan = 0.5, -- Severity [0,1] for protan (red)
          deutan = 0.2, -- Severity [0,1] for deutan (green)
          tritan = 0, -- Severity [0,1] for tritan (blue)
        },
      },
    },
  },
  {
    "AstroNvim/astrotheme",
    opts = {},
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          italic = false,
        },
      })
    end,
  },
}
