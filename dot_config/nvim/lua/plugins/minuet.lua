return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = "openai_compatible",
    provider_options = {
      openai_compatible = {
        name = "Synthetic",
        end_point = "https://api.synthetic.new/openai/v1/chat/completions",
        api_key = "SYNTHETIC_API_KEY", -- name of the env var, not the key itself
        model = "hf:zai-org/GLM-4.7-Flash",
        stream = true,
        optional = { max_tokens = 256 },
      },
    },
    virtualtext = {
      auto_trigger_ft = { "*" },
      keymap = {
        accept = "<A-y>",
        accept_line = "<A-a>",
        next = "<A-]>",
        prev = "<A-[>",
        dismiss = "<A-e>",
      },
    },
  },
}
