return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>g", function()
      require("neogit").open()
    end, { desc = "Open Neogit" })

    require("neogit").setup({
      kind = "floating",
    })
  end
}
