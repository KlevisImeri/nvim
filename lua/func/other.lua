vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})


vim.api.nvim_create_user_command("OilWipe", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "oil" then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, {
  nargs = 0,
  desc = "Remove all the oil buffers"
})


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


vim.api.nvim_create_user_command("Fd", function(opts)
  local args = opts.args or ""
  local results = vim.fn.systemlist("fd " .. args)

  if #results == 0 then
    vim.notify("No results", vim.log.levels.WARN)
    return
  end

  vim.ui.select(results, {
    prompt = "Select:",
  }, function(choice)
    if choice then
      vim.cmd("edit " .. vim.fn.fnameescape(choice))
    end
  end)
end, {
  nargs = "*",
  desc = "Run fd and select result",
})

