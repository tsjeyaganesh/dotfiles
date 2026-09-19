return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua", "python", "javascript", "typescript",
        "go", "rust", "bash", "json", "yaml", "toml", "markdown",
      },
    },
  },
}
