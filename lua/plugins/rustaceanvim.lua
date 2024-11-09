return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  keys = {
    {
      "<C-j>",
      function()
        vim.cmd.RustLsp("joinLines")
      end,
    },
    {
      "<leader>rd",
      function()
        vim.cmd.RustLsp("openDocs")
      end,
    },
  },
  config = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {},
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            check = {
              command = "check",
              extraArgs = { "--profile", "rust-analyzer" },
              workspace = false,
            },
            cachePriming = {
              enable = false,
            },
            -- linkedProjects = { '/home/discord/dev/Cargo.toml' },
            workspace = {
              symbol = {
                search = {
                  kind = "only_types",
                  scope = "workspace",
                },
              },
            },
          },
        },
      },
      -- DAP configuration
      dap = {},
    }
  end,
}
