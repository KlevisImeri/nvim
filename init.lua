-- Load the Lua module from the specific file path
require ("lazy.lazy")


--------------------General Settings---------------------
-- Encoding
vim.opt.encoding = "utf-8"
-- Show line numbers
vim.opt.number = true
-- Status bar
vim.opt.laststatus = 2
-- For the theme
vim.opt.termguicolors = true
-- The indenting after {
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- Easy number navigation
vim.opt.relativenumber = true
-- Mouse input
vim.opt.mouse = "a"
-- Set Font
vim.o.guifont = "Hack Nerd Font:h14"
--------------------General Settings---------------------

-----------------------Shourcuts-------------------------
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })
-- Add // for comments in the selected files
vim.api.nvim_set_keymap('v', '//', ':s/^/\\/\\//<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '//r', ':s/^\\/\\///<CR>', { noremap = true })
-- Run the bat scirpt
vim.api.nvim_set_keymap('n', '<F5>', ':!r.bat<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true })
-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
-- Paste from clipboard
vim.api.nvim_set_keymap('i', '<C-v>', '<Esc>"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true })
-- Fzf shourcut
vim.keymap.set("n", "<C-o>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
-----------------------Shourcuts-------------------------

