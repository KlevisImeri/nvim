--------------------General Settings---------------------
vim.g.python3_host_prog = "D:\\Program Files\\Pyenv\\pyenv-win\\versions\\3.12.1\\python.exe"
-----------------Klevis
-- Encoding
vim.opt.encoding = "utf-8"

-- Show line numbers
vim.opt.number = true

-- Status bar
vim.opt.laststatus = 2

-- For the theme
vim.opt.termguicolors = true

-- The indenting after {
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Easy number navigation
vim.opt.relativenumber = true

-- Mouse input
vim.opt.mouse = "a"

-- Set Font
vim.o.guifont = "Hack Nerd Font:h14"

---------------KickStart.nvim
-- Set Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Set WarpAround where the line starts
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
--------------------General Settings---------------------

-----------------------Shourcuts-------------------------
-----------------Klevis
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })
-- Add // for comments in the selected files
vim.api.nvim_set_keymap("v", "//", ":s/^/\\/\\//<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "//r", ":s/^\\/\\///<CR>", { noremap = true })
-- Run the bat scirpt
vim.api.nvim_set_keymap("n", "<F5>", ":wa<CR>:botright split | resize 16<CR>:term r.bat<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true })
-- Copy to clipboard
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true })
-- Paste from clipboard
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true })
-- Fzf shourcut
vim.keymap.set("n", "<C-f>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
-- Open WinFileExplorer shourcut
-- vim.api.nvim_set_keymap('n', '<C-b>', ':silent !start explorer ' .. vim.fn.expand('%:p:h') .. '<CR><CR>', { silent = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
-- Ctrl S
vim.api.nvim_set_keymap("n", "<C-s>", ":wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
-- Delete Bacspace
-- vim.api.nvim_set_keymap("i", "<C-H>", ":db<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("i", "<C-H>", "<C-W>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<M-BS>", "<C-W>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-Backspace>", "<C-W>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<C-BS>", "dw", { silent = true })
-- vim.keymap.set("n", "<C-Del>", "db", { silent = true })
-- Ctrl A
vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })
-- Ctrl Z
vim.api.nvim_set_keymap("n", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Z>", "u", { noremap = true, silent = true })
-- Shift Select
vim.api.nvim_set_keymap("n", "<S-Left>", "v<Left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "V<Right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Up>", "V<Up>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "v<Down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Home>", "v0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-End>", "v$", { noremap = true, silent = true })

-----------------KickStart.nvim
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-----------------------Shourcuts-------------------------

----------------------AutoCommnads-----------------------
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
----------------------AutoCommnads-----------------------

------------------- Lua Configurations-------------------
require("lazy.lazy")

------------------- Lua Configurations-------------------

-------------General Settings After Plugins--------------
-- vim.api.nvim_command("highlight Normal guibg=NONE")
-- vim.api.nvim_command("highlight LineNr guibg=NONE")
-- vim.api.nvim_command("highlight CursorLineNr guibg=NONE")
-- vim.api.nvim_command("highlight SignColumn guibg=NONE")
-------------General Settings After Plugins--------------
