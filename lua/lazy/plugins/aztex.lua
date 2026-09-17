return {
  "seokgukim/aztex.nvim",
  ft = "coq",
  config = function()
    require("aztex").setup({
      inline_enabled = true,
      inline_triggers = { " ", "\t" },
      math_only = false,
      cmp_enabled = false,
      custom_symbols = require("latex_symbols"),
    })
  end,
}
