return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    require("neogit").setup({
      kind = "replace", -- Open Neogit in the current buffer
    })
  end
}
