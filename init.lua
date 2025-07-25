-----------------Options-----------------
vim.opt.encoding = "utf-8"
vim.opt.number = true
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
vim.opt.expandtab = true
-- vim.opt.spell = true
-- vim.opt.spelllang = "en"
vim.opt.exrc = true
-----------------Options-----------------

------------------------Functions------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command("GitPush", function(opts)
  local commit_message = opts.args
  if commit_message == "" then
    print("Error: No commit message provided")
    return
  end
  local cmd = string.format("!git add . && git commit -m %s && git push", commit_message)
  vim.cmd(cmd)
end, { nargs = 1, complete = "file" })

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

vim.api.nvim_create_user_command("GitStatus", function()
  vim.cmd("!git status")
end, { nargs = 0 })

vim.api.nvim_create_user_command("GitTree", function()
  vim.cmd("!git log --graph --decorate --oneline")
end, { nargs = 0 })

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.pdf", "*.png", "*.jpg", "*.jpeg", "*.svg", "*.md", "*.ico" },
  callback = function()
    vim.fn.jobstart({ "firefox", vim.fn.expand("%") })
  end,
})

vim.api.nvim_create_user_command("MakerpgTerm", function()
  local makeprg = vim.o.makeprg
  local filename = vim.fn.expand('%')
  local cmd = makeprg:gsub("%%", filename)
  vim.cmd("terminal " .. cmd)
  vim.cmd("copen")
end, { nargs = 0 })

vim.api.nvim_create_user_command('RmCom', function(opts)
  local comment_char = opts.args
  local escaped_char = vim.fn.escape(comment_char, '/')
  local cmd = 'g/' .. escaped_char .. '/s/\\s*' .. escaped_char .. '.*//'
  vim.api.nvim_exec(cmd, false)
end,{ nargs = 1, desc = 'Remove comments, e.g., :RmCom //'})

local function toggle_macro_recording()
  if vim.fn.reg_recording() == '' then
    return 'qq'
  else
    return 'q'
  end
end
------------------------Functions------------------------

-----------------------Shourcuts-------------------------
vim.api.nvim_set_keymap("n", "<C-CR>", ":wa<CR>:botright split | resize 16<CR>:term r.bat<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true })
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "<C-v>", '"_d"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-N>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', '"+yy"_dd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-x>', '<C-o>"+yy<C-o>"_dd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+y<ESC>gv"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<BS>", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.api.nvim_set_keymap("n", "<S-Home>", "v0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-End>", "v$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Home>", "<Esc>v0i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-End>", "<Esc>v$i", { noremap = true, silent = true })
vim.keymap.set('v', '<S-right>', 'l', { noremap = true, silent = true })
vim.keymap.set('v', '<S-left>', 'h', { noremap = true, silent = true })
vim.keymap.set('v', '<S-up>', 'k', { noremap = true, silent = true })
vim.keymap.set('v', '<S-down>', 'j', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Up>', '<left><C-o>vk', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Down>', '<C-o>vj', { noremap = true, silent = true })
vim.keymap.set('i', '<S-left>', '<left><C-o>v', { noremap = true, silent = true })
vim.keymap.set('i', '<S-right>', '<C-o>v', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-left>', '<left><C-o>vb', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-right>', '<C-o>vw', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Up>', '<C-o><C-y>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-Up>', '<C-o><C-v>k', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-Down>', '<C-o><C-v>j', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', 'vk', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', 'vj', { noremap = true, silent = true })
vim.keymap.set('n', '<S-left>', 'v', { noremap = true, silent = true })
vim.keymap.set('n', '<S-right>', 'v', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-left>', 'vb', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-right>', 'vw', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<C-y>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Up>', '<C-v>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Down>', '<C-v>j', { noremap = true, silent = true })
vim.keymap.set('n', 'gf','<C-w>f', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>m', toggle_macro_recording, { noremap = true, silent = true, expr = true })
vim.keymap.set('v', '<leader>m', ":'<,'>norm @q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>>', '20<C-w>>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><', '20<C-w><', { noremap = true, silent = true })
-----------------------Shourcuts-------------------------

-----------------------Clipboard-------------------------
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }
-----------------------Clipboard-------------------------

-----------------------Transparent-----------------------
-- vim.api.nvim_command("highlight Normal guibg=NONE")
-- vim.api.nvim_command("highlight LineNr guibg=NONE")
-- vim.api.nvim_command("highlight CursorLineNr guibg=NONE")
-- vim.api.nvim_command("highlight SignColumn guibg=NONE")
-----------------------Transparent-----------------------

require("lazy.lazy")
