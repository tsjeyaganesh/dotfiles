return {
  "3rd/diagram.nvim",
  ft = { "markdown", "norg" },
  dependencies = {
    {
      "3rd/image.nvim",
      opts = {
        backend = "kitty",
        processor = "magick_cli",
      },
    },
  },
  opts = function()
    return {
      integrations = {
        require("diagram.integrations.markdown"),
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
        },
      },
    }
  end,
}
