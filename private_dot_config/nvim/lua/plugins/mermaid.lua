return {
  "kevalin/mermaid.nvim",
  ft = { "mermaid" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("mermaid").setup()
  end,
}
