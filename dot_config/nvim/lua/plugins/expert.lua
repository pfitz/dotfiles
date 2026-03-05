return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "expert",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")
      
      -- Add expert as a custom server
      if not configs.expert then
        configs.expert = {
          default_config = {
            cmd = { "expert" },
            filetypes = { "elixir", "eelixir", "heex" },
            root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),
            settings = {},
          },
        }
      end
      
      lspconfig.expert.setup({
        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          
          -- Navigation
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          
          -- Documentation
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, opts)
          
          -- Code actions
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)
          
          -- Formatting
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          
          -- Symbols
          vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, opts)
          vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
          
          -- Diagnostics
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
        end,
      })
    end,
  },
}