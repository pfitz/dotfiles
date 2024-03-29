return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- nls.builtins.formatting.prettierd,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.phpstan,
        nls.builtins.diagnostics.credo,
        nls.builtins.formatting.mix,
        nls.builtins.formatting.phpcbf,
        nls.builtins.formatting.stylua,
      },
    }
  end,
}
