vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


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

-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = { "*.pdf", "*.png", "*.jpg", "*.jpeg", "*.svg", "*.md", "*.ico" },
--   callback = function()
--     vim.fn.jobstart({ "firefox", vim.fn.expand("%") })
--   end,
-- })

vim.api.nvim_create_user_command("Firefox", function()
  local filename = vim.fn.expand('%')

  if filename == '' then
    vim.notify("No file is currently open", vim.log.levels.WARN)
    return
  end

  vim.fn.jobstart({ 'firefox', filename }, {
    detach = true,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.notify("Failed to open Firefox", vim.log.levels.ERROR)
      end
    end
  })
end, {
  nargs = 0,
  desc = "Open current file in Firefox browser"
})

vim.api.nvim_create_user_command("Make", function()
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

vim.api.nvim_create_user_command("E", function(opts) 
  local current_dir = vim.fn.expand('%:h') 
  local new_filename = opts.args

  if new_filename == "" then
    vim.notify("Error: No filename provided", vim.log.levels.ERROR)
    return
  end

  if current_dir == "" then
    current_dir = vim.fn.getcwd() 
  end

  local full_path = current_dir .. "/" .. new_filename
  vim.cmd("edit " .. vim.fn.fnameescape(full_path))
  vim.cmd("write")
  vim.notify("Created file: " .. full_path, vim.log.levels.INFO)
end, {
  nargs = 1,
  desc = 'Create file in the current directory of the opened file',
  complete = "file"
})

vim.api.nvim_create_user_command("Source", function()
  local config_dir = vim.fn.stdpath("config")
  local init_file = config_dir .. "/init.lua"

  local success, err = pcall(dofile, init_file)

  if success then
    vim.notify("Successfully sourced " .. init_file, vim.log.levels.INFO)
  else
    vim.notify(
      "Error sourcing " .. init_file .. ". See quickfix list for details.",
      vim.log.levels.ERROR
    )

    local filename, lnum, message = string.match(err, "([^:]+):(%d+): (.*)")

    local qf_list = {}
    if filename and lnum and message then
      table.insert(qf_list, {
        filename = filename,
        lnum = tonumber(lnum), 
        text = message,
      })
    else
      table.insert(qf_list, {
        filename = init_file,
        lnum = 1, 
        text = err, 
      })
    end

    vim.fn.setqflist(qf_list)
    vim.cmd("copen")
  end
end, { desc = "Source the main init.lua configuration file" })
