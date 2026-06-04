return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup {}

    require("nvim-treesitter").install {
      "bash", "c", "cpp", "c_sharp", "css", "html", "java", "javascript", "json",
      "jinja", "jinja_inline", "kotlin", "lua", "markdown", "toml", "tsx",
      "typescript", "vim", "vimdoc", "go", "rust", "svelte", "tera", "vue",
    }

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
        if ok and parser then
          pcall(vim.treesitter.start)
        end
      end,
    })
  end,
}
