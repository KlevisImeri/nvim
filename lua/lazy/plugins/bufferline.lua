return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	options = {
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return " " .. icon .. count
		end,
	},
	config = function()
		vim.opt.termguicolors = true
		vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-w>", ":bd<CR>", { noremap = true, silent = true })
		require("bufferline").setup({})
	end,
}
