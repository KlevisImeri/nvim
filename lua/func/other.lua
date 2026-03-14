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

  local items = {}
  for _, path in ipairs(results) do
    table.insert(items, { filename = path, lnum = 1, col = 1, text = path })
  end

  vim.fn.setqflist(items)
  vim.cmd("copen")
end, {
  nargs = "*",
  desc = "Run fd and put results in quickfix",
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", function()
      local qf = vim.fn.getqflist()
      local line = vim.fn.line(".")
      table.remove(qf, line)
      vim.fn.setqflist(qf, "r")
    end, { buffer = true, desc = "Delete quickfix entry" })
  end,
})

