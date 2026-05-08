local parsing = require("func.parsing")

local function toggle_macro_recording()
  if vim.fn.reg_recording() == '' then
    return 'qq'
  else
    return 'q'
  end
end

local function select_all_and_return()
  local pos = vim.fn.getpos(".")
  vim.cmd("normal! ggVG")
  vim.api.nvim_create_autocmd("ModeChanged", {
    once = true,
    pattern = "V:*",
    callback = function()
      vim.fn.setpos(".", pos)
    end,
  })
end

local function open_oil()
  if vim.bo.buftype == "terminal" then
    require("oil").open(vim.fn.getcwd())
  else
    require("oil").open()
  end
end


local function open_selected_markdown()
  vim.cmd('normal! "zy')
  local selected_text = vim.fn.getreg('z')
  local tmpfile = '/tmp/nvim_math_preview.md'
  local f = io.open(tmpfile, 'w')
  if f then
    f:write(selected_text);
    f:close()
    vim.fn.jobstart('firefox ' .. tmpfile)
  end
end

local function copy_range_reference()
  vim.cmd('normal! "zy')
  local start = vim.fn.getpos("'<")
  local end_ = vim.fn.getpos("'>")
  local filepath = vim.fn.expand('%:p')
  local range_str = string.format("%s:%d:%d:%d:%d", filepath, start[2], start[3], end_[2], end_[3])
  vim.fn.setreg('+', range_str)
  vim.notify("Copied: " .. range_str, vim.log.levels.INFO)
end

local function gf_jump_to_file()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')
  local s = col
  while s > 1 and not line:sub(s - 1, s - 1):match('%s') do s = s - 1 end
  local e = col
  while e <= #line and not line:sub(e, e):match('%s') do e = e + 1 end
  local pattern = line:sub(s, e - 1)
  print(pattern)
  local file, line, col = pattern:match('^([^:]+):(%d+):(%d+)$')
  if not (file and line) then
   file, line = pattern:match('^([^:]+):(%d+)$')
  end
  if file and line then
    file = vim.fn.expand(file)
    line, col = tonumber(line), tonumber(col)
    if not line or line < 1 then
      print("Line out of range, clamped to 1")
      line = 1
    end
    if not col or col < 1 then
      print("Col out of range, clamped to 1")
      col = 1
    end
    if vim.fn.filereadable(file) == 0 then
       print("File not found: " .. file)
       return
    end
    line, col = line, col - 1
    local bufnr = vim.fn.bufadd(file)
    vim.fn.bufload(bufnr)
    local total_lines = vim.api.nvim_buf_line_count(bufnr)
    if line > total_lines then
      print(string.format("Line %d out of range (file has %d lines): %s", line, total_lines, file))
      line = total_lines
    end
    local line_len = #vim.api.nvim_buf_get_lines(bufnr, line - 1, line, true)[1]
    if col > line_len then
       print(string.format("Col %d out of range (line %d has %d cols): %s:%d:%d", col + 1, line, line_len, file, line, col + 1))
       col = line_len
    end
    vim.cmd('edit ' .. file)
    vim.api.nvim_win_set_cursor(0, { line, col })
  else
    print("Defaulted to normal!")
    vim.cmd('normal! gf')
  end
end

-- WARN: a lag in the insert mode when you press space, because its wating for
--       the next command

vim.keymap.set("n", "gf", gf_jump_to_file, { desc = "Go to file:line:col" })
vim.keymap.set("n", "<C-CR>", ":Recompile<CR>", { desc = "Recompile" })
vim.keymap.set("n", "<leader>e", ":ParseErrors<CR>", { desc = "Parse errors", silent = true })
vim.keymap.set("n", "<C-a>", select_all_and_return, { desc = "Select all", silent = true })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-v>", '<Esc>"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-v>", '"_d"+P', { desc = "Paste over selection", silent = true })
vim.keymap.set("n", "-", open_oil, { desc = "Open oil in current directory" })
vim.keymap.set("n", "<C-s>", ":wa<CR>", { desc = "Save all", silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>", { desc = "Save all", silent = true })
vim.keymap.set("v", "<C-s>", "<Esc>:wa<CR>", { desc = "Save all", silent = true })
vim.keymap.set("i", "<C-BS>", "<C-W>", { desc = "Delete word", silent = true })
vim.keymap.set("n", "<C-Z>", "u", { desc = "Undo", silent = true })
vim.keymap.set("i", "<C-Z>", "u", { desc = "Undo", silent = true })
vim.keymap.set("v", "<C-x>", '"+y<ESC>gv"_d', { desc = "Cut to clipboard", silent = true })
vim.keymap.set("n", "d", '"_d', { desc = "Delete (no yank)" })
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete line (no yank)" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Decrease indent", silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Decrease indent", silent = true })
vim.keymap.set("v", "<leader>S", ":s/\\s\\+$<CR>", { desc = "Strip trailing whitespace" })
vim.keymap.set("n", "<leader>S", ":%s/\\s\\+$<CR>", { desc = "Strip trailing whitespace" })
vim.keymap.set("v", "<BS>", '"_d', { desc = "Delete (no yank)", silent = true })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Increase indent", silent = true })
vim.keymap.set("t", "<Esc>", "<Esc><C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<S-Home>", "v0", { desc = "Select to line start", silent = true })
vim.keymap.set("n", "<S-End>", "v$", { desc = "Select to line end", silent = true })
vim.keymap.set("i", "<S-Home>", "<Esc>v0i", { desc = "Select to line start", silent = true })
vim.keymap.set("i", "<S-End>", "<Esc>v$i", { desc = "Select to line end", silent = true })
vim.keymap.set("v", "<S-right>", "l", { desc = "Extend selection right", silent = true })
vim.keymap.set("v", "<S-left>", "h", { desc = "Extend selection left", silent = true })
vim.keymap.set("v", "<S-up>", "k", { desc = "Extend selection up", silent = true })
vim.keymap.set("v", "<S-down>", "j", { desc = "Extend selection down", silent = true })
vim.keymap.set("i", "<S-Up>", "<left><C-o>vk", { desc = "Select up", silent = true })
vim.keymap.set("i", "<S-Down>", "<C-o>vj", { desc = "Select down", silent = true })
vim.keymap.set("i", "<S-left>", "<left><C-o>v", { desc = "Select left", silent = true })
vim.keymap.set("i", "<S-right>", "<C-o>v", { desc = "Select right", silent = true })
vim.keymap.set("i", "<C-S-left>", "<left><C-o>vb", { desc = "Select word left", silent = true })
vim.keymap.set("i", "<C-S-right>", "<C-o>vw", { desc = "Select word right", silent = true })
vim.keymap.set("i", "<C-Up>", "<C-o><C-y>", { desc = "Scroll up", silent = true })
vim.keymap.set("i", "<C-S-Up>", "<C-o><C-v>k", { desc = "Select block up", silent = true })
vim.keymap.set("i", "<C-S-Down>", "<C-o><C-v>j", { desc = "Select block down", silent = true })
vim.keymap.set("n", "<S-Up>", "vk", { desc = "Select up", silent = true })
vim.keymap.set("n", "<S-Down>", "vj", { desc = "Select down", silent = true })
vim.keymap.set("n", "<S-left>", "v", { desc = "Select left", silent = true })
vim.keymap.set("n", "<S-right>", "v", { desc = "Select right", silent = true })
vim.keymap.set("n", "<C-S-left>", "vb", { desc = "Select word left", silent = true })
vim.keymap.set("n", "<C-S-right>", "vw", { desc = "Select word right", silent = true })
vim.keymap.set("n", "<C-Up>", "<C-y>", { desc = "Scroll up", silent = true })
vim.keymap.set("n", "<C-S-Up>", "<C-v>k", { desc = "Select block up", silent = true })
vim.keymap.set("n", "<C-S-Down>", "<C-v>j", { desc = "Select block down", silent = true })
vim.keymap.set("n", "<leader>m", toggle_macro_recording, { desc = "Toggle macro recording", silent = true, expr = true })
vim.keymap.set("v", "<leader>m", ":'<,'>norm @q<CR>", { desc = "Apply macro to selection", silent = true })
vim.keymap.set("n", "<C-w>>", "20<C-w>>", { desc = "Widen window", silent = true })
vim.keymap.set("n", "<C-w><", "20<C-w><", { desc = "Narrow window", silent = true })
vim.keymap.set("n", "<leader>n", ":cnext<CR>", { desc = "Next in quickfix" })
vim.keymap.set("n", "<leader>N", ":cprevious<CR>", { desc = "Previous in quickfix" })
vim.keymap.set("x", "<leader>fp", open_selected_markdown, { desc = "review selected Latex/Math in Firefox" })
vim.keymap.set("v", "<leader>cp", copy_range_reference, { desc = "Copy range reference", silent = true })
