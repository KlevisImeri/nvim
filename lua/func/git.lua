vim.api.nvim_create_user_command("GitDiff", function(opts)
  local branch = opts.args
  if branch == "" then
    require('gitsigns').diffthis()
  else
    require('gitsigns').diffthis(branch)
  end
end, {
  nargs = '?',
  complete = function(ArgLead, CmdLine, CursorPos)
    local handle = io.popen("git branch --format='%(refname:short)'")
    local result = handle:read("*a")
    handle:close()
    local branches = {}
    for s in result:gmatch("[^\r\n]+") do
      table.insert(branches, s)
    end
    return vim.tbl_filter(function(s)
      return string.sub(s, 1, string.len(ArgLead)) == ArgLead
    end, branches)
  end
})
vim.keymap.set('n', '<leader>gdh', '<cmd>GitDiff<CR>', { desc = "[G]it [D]iff [H]ere" })
vim.keymap.set('n', '<leader>gdm', '<cmd>GitDiff main<CR>', { desc = "[G]it [D]iff [M]ain" })
vim.keymap.set('n', '<leader>gda', '<cmd>GitDiff master<CR>', { desc = "[G]it [D]iff m[a]ster" })
vim.keymap.set('n', '<leader>gD', ':GitDiff ', { desc = "[G]it [D]iff (Command)" })

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

