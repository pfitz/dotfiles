return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "catppuccin/nvim" },
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        local ok, bufferline_integration = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and bufferline_integration.get_theme then
          opts.highlights = bufferline_integration.get_theme()
        end
      end
      return opts
    end,
  },
}