# Should open the file at line 42, column 10
/home/klevis/.config/nvim/lua/shourcuts.lua:42:10

# Should open at line 1, column 0 (start of file)
/home/klevis/.config/nvim/lua/shourcuts.lua:1:0

# Should open at line 56, column 0 (the gf keymap line)
/home/klevis/.config/nvim/lua/shourcuts.lua:68:0

# Should open at line 50 (the copy_range_reference function)
/home/klevis/.config/nvim/init.lua:1:0

# Should fallback to default gf (no :line:col)
/home/klevis/.config/nvim/init.lua

# Should also fallback (only line, no col — uses default gf)
/home/klevis/.config/nvim/init.lua:5

# Column 1 (first char)
/home/klevis/.config/nvim/lua/shourcuts.lua:42:1

# Line 999 (out of range — should print error)
/home/klevis/.config/nvim/lua/shourcuts.lua:999:0

# File doesn't exist (should print error)
/home/klevis/nonexistent.lua:1:0

# No line, no col — fallback to normal gf
/home/klevis/.config/nvim/lua/shourcuts.lua

# Only line, no col
/home/klevis/.config/nvim/lua/shourcuts.lua:42

# Relative path
lua/shourcuts.lua:1:0

# File with spaces in path
/home/klevis/my file.lua:1:0

# Line 0 (out of range — should print error)
/home/klevis/.config/nvim/lua/shourcutslua:0:0

# Column way beyond line length (should clamp, not error)
/home/klevis/.config/nvim/lua/shourcuts.lua:1:9999

# Multiple file refs on same line — cursor on second one
/home/klevis/.config/nvim/lua/shourcuts.lua:1:0 see also
/home/klevis/.config/nvim/init.lua:5:3

# Negative line number
/home/klevis/.config/nvim/lua/shourcuts.lua:-1:0

# Non-numeric after colons
/home/klevis/.config/nvim/lua/shourcuts.lua:abc:def

# Tilde home path
~/.config/nvim/lua/shourcuts.lua:1:0

# File with multiple extensions
/home/klevis/.config/nvim/test.file.lua:1:0
