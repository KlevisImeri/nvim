return {
  "numToStr/Comment.nvim",
  lazy = false,
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      toggler = {
        line = "<C-/>",
        block = "gbc",
      },
      opleader = {
        line = "<C-/>",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
    })
  end,
}
