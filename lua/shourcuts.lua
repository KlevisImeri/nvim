local parsing = require("func.parsing")

local function toggle_macro_recording()
  if vim.fn.reg_recording() == '' then
    return 'qq'
  else
    return 'q'
  end
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

  oil_toggle()
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
vim.api.nvim_set_keymap("n", "<C-CR>", ":term ./r.sh<CR>", { noremap = true })
vim.keymap.set('n', '<leader>e', ":ParseErrors<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true })
vim.api.nvim_set_keymap("i", "<C-v>", '<Esc>"+p', { noremap = true })
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true })
vim.api.nvim_set_keymap("v", "<C-v>", '"_d"+P', { noremap = true, silent = true })
vim.keymap.set("n", "-", oil_toggle, { desc = "Toggle Oil File Explorer" })
vim.api.nvim_set_keymap("n", "<C-s>", ":wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<Esc>:wa<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-A>", "ggVG", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Z>", "u", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-x>', '"+yy"_dd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-x>', '<C-o>"+yy<C-o>"_dd', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-x>', '"+y<ESC>gv"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })
vim.api.nvim_set_keymap("n", "dd", '"_dd', { noremap = true })
vim.api.nvim_set_keymap("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", "<<", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<BS>", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.api.nvim_set_keymap("n", "<S-Home>", "v0", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-End>", "v$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Home>", "<Esc>v0i", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-End>", "<Esc>v$i", { noremap = true, silent = true })
vim.keymap.set('v', '<S-right>', 'l', { noremap = true, silent = true })
vim.keymap.set('v', '<S-left>', 'h', { noremap = true, silent = true })
vim.keymap.set('v', '<S-up>', 'k', { noremap = true, silent = true })
vim.keymap.set('v', '<S-down>', 'j', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Up>', '<left><C-o>vk', { noremap = true, silent = true })
vim.keymap.set('i', '<S-Down>', '<C-o>vj', { noremap = true, silent = true })
vim.keymap.set('i', '<S-left>', '<left><C-o>v', { noremap = true, silent = true })
vim.keymap.set('i', '<S-right>', '<C-o>v', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-left>', '<left><C-o>vb', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-right>', '<C-o>vw', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Up>', '<C-o><C-y>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-Up>', '<C-o><C-v>k', { noremap = true, silent = true })
vim.keymap.set('i', '<C-S-Down>', '<C-o><C-v>j', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', 'vk', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', 'vj', { noremap = true, silent = true })
vim.keymap.set('n', '<S-left>', 'v', { noremap = true, silent = true })
vim.keymap.set('n', '<S-right>', 'v', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-left>', 'vb', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-right>', 'vw', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<C-y>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Up>', '<C-v>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Down>', '<C-v>j', { noremap = true, silent = true })
vim.keymap.set('n', 'gf','<C-w>f', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>m', toggle_macro_recording, { noremap = true, silent = true, expr = true })
vim.keymap.set('v', '<leader>m', ":'<,'>norm @q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>>', '20<C-w>>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w><', '20<C-w><', { noremap = true, silent = true })
vim.keymap.set('n', 'cd', cd_to_terminal_path, { noremap = true, silent = false })
vim.keymap.set('n','<leader>cl', clear_term, { desc = "[C]lears the [t]erminal"})
