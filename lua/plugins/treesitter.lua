return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "dockerfile",
        "haskell",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "ron",
        "rust",
        "toml",
        "hcl",
        "tsx",
        "typescript",
      },
      autotag = {
        -- Setup autotag using treesitter config.
        enable = true,
      },
    },
  },
}
