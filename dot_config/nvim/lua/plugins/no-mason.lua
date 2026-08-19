-- Linux (devcontainer) only: LSP servers come from the Nix flake, not Mason.
-- Mason downloads prebuilt binaries that expect an FHS dynamic linker, which a
-- Nix-based image does not provide. Both owner spellings are listed because
-- LazyVim renamed these plugins; disabling one that is not in use is inert.
return {
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Flake-provided binaries are already on PATH.
      servers = {
        expert = {},
        lua_ls = {},
        gopls = {},
        terraformls = {},
      },
    },
  },
}
