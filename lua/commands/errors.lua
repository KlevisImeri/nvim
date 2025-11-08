vim.api.nvim_create_user_command("ParseErrors", function(opts)
  local bufnr = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  vim.cmd('cclose')

  local output = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  vim.fn.setqflist({}, 'r', { lines = output })

  if #vim.fn.getqflist() > 0 then
    vim.api.nvim_buf_delete(bufnr, { force = true }) 
    vim.cmd('copen')
    vim.cmd('cfirst') 
  end
end, {
  nargs = 0,
  desc = "Populate quickfix list with the errors in the current buffer."
})
