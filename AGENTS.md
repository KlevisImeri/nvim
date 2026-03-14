# AGENTS.md - Code Organization Guide

This is a Neovim Lua configuration using lazy.nvim plugin manager.

## Directory Structure

```
/
├── init.lua                    # Entry point
├── lua/
│   ├── options.lua             # Neovim settings
│   ├── shourcuts.lua          # Key mappings
│   ├── func/
│   │   ├── func.lua           # Requires all func modules
│   │   ├── git.lua            # Git utilities
│   │   ├── parsing.lua        # Parsing utilities (terminal prompts)
│   │   └── other.lua          # Miscellaneous utilities
│   └── lazy/
│       ├── lazy.lua           # Plugin bootstrap
│       └── plugins/           # Individual plugin configs
│           ├── autopairs.lua
│           ├── comment.lua
│           ├── easyalign.lua
│           ├── gitsigns.lua
│           ├── githubtheme.lua
│           ├── img-clip.lua
│           ├── lualine.lua
│           ├── multicursor.lua
│           ├── which-key.lua
│           ├── treesitter.lua
│           ├── todo-comments.lua
│           ├── splitjoin.lua
│           ├── telescope.luaOld    # disabled
│           └── oil.luaOld           # disabled
```

## Quick Reference

| Task | File |
|------|------|
| Change Neovim settings | `lua/options.lua` |
| Add/modify keymaps | `lua/shourcuts.lua` |
| Add new plugin | Create file in `lua/lazy/plugins/` |
| Add utility functions | Add to `lua/func/` |

## Notes

- Disabled plugins have `.luaOld` extension
- Plugin configs follow lazy.nvim spec format (table return with `name`, `event`, `dependencies`, `config`)
