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
      "vimdoc"
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    compilers = { vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl", "zig", "cargo"},
  },
}
