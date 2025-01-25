-----------------Options-----------------
vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.laststatus = 2
vim.opt.termguicolors = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.o.guifont = "Hack Nerd Font:h14"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
-----------------Options-----------------

-----------------------Shourcuts-------------------------
vim.api.nvim_set_keymap("n", "<C-CR>", ":wa<CR>:botright split | resize 16<CR>:term r.bat<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true })
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-N>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-x>", "dd:<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("v", "<S-Left>", "v<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Right>", "v<Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Up>", "v<Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Down>", "v<Down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Left>", "<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Right>", "<Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Up>", "<Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Down>", "<Down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-C-Left>", "<C-Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-C-Right>", "<C-Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-C-Up>", "<C-Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-C-Down>", "<C-Down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Left>", "v<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "v<Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Up>", "v<Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "v<Down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Home>", "v0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-End>", "v$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Home>", "<Esc>v0i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-End>", "<Esc>v$i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<BS>", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", "w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-----------------------Shourcuts-------------------------

-----------------------Transparent-----------------------
-- vim.api.nvim_command("highlight Normal guibg=NONE")
-- vim.api.nvim_command("highlight LineNr guibg=NONE")
-- vim.api.nvim_command("highlight CursorLineNr guibg=NONE")
-- vim.api.nvim_command("highlight SignColumn guibg=NONE")
-----------------------Transparent-----------------------

----------------------AutoCommnads-----------------------
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
----------------------AutoCommnads-----------------------

--------------------------Git ---------------------------
-- :GitPush "commit comment here"
vim.api.nvim_create_user_command("GitPush", function(opts)
	local commit_message = opts.args
	if commit_message == "" then
		print("Error: No commit message provided")
		return
	end
	local cmd = string.format("!git add . && git commit -m %s && git push", commit_message)
	vim.cmd(cmd)
end, { nargs = 1, complete = "file" })

-- :GitCommit "commmit comment here"
vim.api.nvim_create_user_command("GitCommit", function(opts)
	local commit_message = opts.args
	if commit_message == "" then
		print("Error: No commit message provided")
		return
	end
	local cmd = string.format("!git add . && git commit -m %s", commit_message)
	vim.cmd(cmd)
end, { nargs = 1 })

vim.api.nvim_create_user_command("GitLog", function()
	vim.cmd("!git log --oneline --graph --all --decorate")
end, {})
--------------------------Git ---------------------------

require("lazy.lazy")
