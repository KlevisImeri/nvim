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

