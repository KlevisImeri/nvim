return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "html",
      "lua",
      "markdown",
      "vim",
      "vimdoc",
      "go",
      "rust",
      "typescript",
    },
    auto_install = true,
  },
}
