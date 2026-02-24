return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      markdown = { "prettier" },
      -- other filetypes...
    },
    formatters = {
      prettier = {
        extra_args = { "--print-width", "80" },
      },
    },
  },
}
