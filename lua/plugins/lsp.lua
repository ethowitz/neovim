return {
  {
    -- LSP configuration
    "neovim/nvim-lspconfig",
    config = function()
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = "",
        })
      end

      sign({ name = "DiagnosticSignError", text = " " })
      sign({ name = "DiagnosticSignWarn", text = " " })
      sign({ name = "DiagnosticSignHint", text = "󰌵 " })
      sign({ name = "DiagnosticSignInfo", text = "󰋼 " })

      vim.diagnostic.config({ severity_sort = true })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local lsp_opts = { noremap = true, silent = true, buffer = ev.buf }
          local telescope = require("telescope.builtin")

          require("which-key").add({
            {
              "gD",
              function()
                vim.lsp.buf.declaration()
              end,
              desc = "go to declaration",
            },
            {
              "gd",
              function()
                telescope.lsp_definitions()
              end,
              desc = "go to definition(s) of symbol under cursor",
            },
            {
              "gt",
              function()
                telescope.lsp_type_definitions()
              end,
              desc = "go to definition(s) of the type of the symbol under cursor",
            },
            {
              "gr",
              function()
                telescope.lsp_references()
              end,
              desc = "search references to symbol under cursor",
            },
            {
              "gi",
              function()
                telescope.lsp_implementations()
              end,
              desc = "search implementations of the symbol under cursor",
            },
            {
              "gI",
              function()
                telescope.lsp_incoming_calls()
              end,
              desc = "list incoming calls",
            },
            {
              "gO",
              function()
                telescope.lsp_outgoing_calls()
              end,
              desc = "list outgoing calls",
            },
            {
              "K",
              vim.lsp.buf.hover,
              desc = "show LSP diagnostic info in hover",
            },
            {
              "<C-k>",
              vim.lsp.buf.signature_help,
              desc = "show LSP signature help in hover",
            },
            {
              "<space>e",
              ":lua vim.diagnostic.open_float()<CR>",
              desc = "open LSP diagnostic float",
            },
            {
              "<space>q",
              ":lua vim.diagnostic.setloclist()<CR>",
              desc = "set the loclist with LSP diagnostics",
            },
            {
              "[d",
              function()
                vim.diagnostic.goto_prev({
                  float = false,
                  severity = {
                    min = vim.diagnostic.severity.WARN,
                  },
                })
              end,
              desc = "go to previous LSP diagnostic",
            },
            {
              "]d",
              function()
                vim.diagnostic.goto_prev({
                  float = false,
                  severity = {
                    min = vim.diagnostic.severity.WARN,
                  },
                })
              end,
              desc = "go to next LSP diagnostic",
            },
          }, lsp_opts)

          -- Highlight word under cursor
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = ev.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = ev.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })

      local lspconfig = require("lspconfig")
      local navic = require("nvim-navic")

      local on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cachePriming = {
              enable = true,
            },
            cargo = {
              features = "all",
            },
            check = {
              command = "clippy",
              extraArgs = { "--profile", "rust-analyzer", "--", "-W", "clippy::disallowed_methods" },
            },
            lru = {
              capacity = 512,
            },
            workspace = {
              symbol = {
                search = {
                  kind = "only_types",
                  limit = 128,
                  scope = "workspace",
                },
              },
            },
          },
        },
      })
    end,
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
  {
    -- Package manager for LSP servers
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "rust-analyzer", -- rust
        "lua-language-server", -- lua
        "terraform-ls", -- terraform
        "taplo", -- toml
        "json-lsp", -- json
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      icons = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
      highlight = false,
      separator = "  ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
    },
  },
  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = "never"
        else
          lsp_format_opt = "fallback"
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort" },
        rust = { "rustfmt", lsp_format = "fallback" },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
}
