return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup {}

    require("nvim-treesitter").install {
      "bash", "c", "cpp", "c_sharp", "html", "java", "json", "kotlin", "lua", "markdown",
      "vim", "vimdoc", "go", "rust", "tsx", "typescript", "vue",
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
