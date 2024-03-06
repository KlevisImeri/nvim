-- Encoding
vim.opt.encoding = "utf-8"

-- Show line numbers
vim.opt.number = true

-- Status bar
vim.opt.laststatus = 2

-- For the theme
vim.opt.termguicolors = true

-- The indenting after {
vim.opt.shiftwidth = 3
vim.opt.tabstop = 3

-- Easy number navigation
vim.opt.relativenumber = true

-- Mouse input
vim.opt.mouse = "a"

-- Shortcuts
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('v', '//', ':s/^/\\/\\//<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '//r', ':s/^\\/\\///<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', ':!r.bat<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', '"+y', { noremap = true })

-- Plugins
require('plug').begin('~/.config/nvim/plugged')

-- Comment and uncomment lines
-- require('plug').add('itchyny/nerdcommenter')

-- Color theme
require('plug').add('bluz71/vim-nightfly-guicolors')
require('plug').add('vim-airline/vim-airline')
require('plug').add('https://tpope.io/vim/commentary.git')
require('plug').add('NLKNguyen/papercolor-theme')

require('plug').end()

-- Choose theme

-- Nightfly
vim.cmd('colorscheme nightfly')

-- Paper
-- vim.opt.t_Co = 256
-- vim.opt.background = 'light'
-- vim.cmd('colorscheme PaperColor')
-- vim.g.airline_theme = 'papercolor'

