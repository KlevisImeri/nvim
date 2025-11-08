local function extract_path_from_prompt(prompt_line)
  local path = prompt_line:match("~([^($]*)")
  if path then
    path = vim.fn.expand("~") .. path
  else
    path = prompt_line:match("(/[^($]*)") -- WARN: Works for specifc bashrc promt
  end
  return path
end

local function get_terminal_prompt_line()
  local bufnr = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    vim.notify("Could not get current buffer", vim.log.levels.WARN)
    return ""
  end
 
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1]
  local prompt_line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""
  
  return prompt_line
end

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

return {
  extract_path_from_prompt = extract_path_from_prompt,
  get_terminal_prompt_line = get_terminal_prompt_line,
}

