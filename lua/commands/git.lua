vim.keymap.set('n', '<leader>gdh', '<cmd>Gitsigns diffthis<CR>', { desc = "[G]it [D]iff [H]ere" })

vim.keymap.set('n', '<leader>gdm', function()
  require('gitsigns').diffthis('main')
end, { desc = "[G]it [D]iff [M]ain" })

vim.api.nvim_create_user_command("GitPush", function(opts)
  local commit_message = opts.args
  if commit_message == "" then
    print("Error: No commit message provided")
    return
  end
  local cmd = string.format("!git add . && git commit -m %s && git push", commit_message)
  vim.cmd(cmd)
end, { nargs = 1, complete = "file" })
vim.keymap.set('n', '<leader>gp', ':GitPush "', { desc = "[G]it [P]ush" })

vim.api.nvim_create_user_command("GitCommit", function(opts)
  local commit_message = opts.args
  if commit_message == "" then
    print("Error: No commit message provided")
    return
  end
  local cmd = string.format("term git add . && git commit -m %s", commit_message)
  vim.cmd(cmd)
end, { nargs = 1 })
vim.keymap.set('n', '<leader>gc', ':GitCommit "', { desc = "[G]it [C]ommit" })

vim.api.nvim_create_user_command("GitLog", function()
  vim.cmd("term git log --oneline --graph --all --decorate")
end, {})
vim.keymap.set('n', '<leader>gl', '<cmd>GitLog<CR>', { desc = "[G]it [L]og" })

vim.api.nvim_create_user_command("GitStatus", function()
  vim.cmd("term git status")
end, { nargs = 0 })
vim.keymap.set('n', '<leader>gs', '<cmd>GitStatus<CR>', { desc = "[G]it [S]tatus" })

-- vim.api.nvim_create_user_command("GitTree", function()
--   vim.cmd("term git log --graph --decorate --oneline")
-- end, { nargs = 0 })

