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

local function oil_toggle()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  elseif vim.bo.buftype == "terminal" then
    local prompt_line = parsing.get_terminal_prompt_line()
    local path = parsing.extract_path_from_prompt(prompt_line)
    vim.notify("Path: " .. (path or "nil"), vim.log.levels.INFO)
    if path then
      require("oil").open(path)
    else
      require("oil").open()
    end
  else
    require("oil").open()
  end
end

local function cd_to_terminal_path()
  local prompt_line = parsing.get_terminal_prompt_line()
  local path = parsing.extract_path_from_prompt(prompt_line)

  if not path then
    vim.notify("Could not extract path from prompt", vim.log.levels.WARN)
    return
  end

  vim.cmd("cd " .. path)
  vim.notify("Changed directory to: " .. path, vim.log.levels.INFO)

  local local_rc = path .. "/.nvim.lua"
  if vim.loop.fs_stat(local_rc) then
    vim.cmd("luafile " .. local_rc)
    vim.notify("Loaded local config: " .. local_rc, vim.log.levels.INFO)
  end
end

local function clear_term()
  vim.cmd('startinsert')
  vim.api.nvim_input("clear" .. "<CR>")
  local org_scrollback = vim.opt_local.scrollback._value
  vim.cmd("set scrollback=1")
  vim.cmd("set scrollback=" .. org_scrollback)
end

-- WARN: only use <leader> key when you are in normal mode else there will be
--       a lag in the insert mode when you press space, because its wating for
--       the next command

vim.keymap.set("n", "<C-CR>", ":term ./r.sh<CR>", { desc = "Run r.sh in terminal" })
vim.keymap.set("n", "<leader>e", ":ParseErrors<CR>", { desc = "Parse errors", silent = true })
vim.keymap.set("n", "<C-a>", select_all_and_return, { desc = "Select all", silent = true })
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-v>", '<Esc>"+p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<C-v>", '"_d"+P', { desc = "Paste over selection", silent = true })
vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Toggle Oil File Explorer" })
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
vim.keymap.set("n", "cd", cd_to_terminal_path, { desc = "CD to terminal path" })
vim.keymap.set("n", "<leader>cl", clear_term, { desc = "[C]lears the [t]erminal" })
