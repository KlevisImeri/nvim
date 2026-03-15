<div align="center">
  <h1>My Nvim Configuration</h1>
</div>

## Plugins
| Plugin | Description |
|--------|-------------|
| oil | File explorer |
| gitsigns | Git signs in gutter |
| treesitter | Syntax highlighting |
| lualine | Status line |
| which-key | Keybinding help popup |
| comment | Toggle comments |
| autopairs | Auto brackets/quotes |
| multicursor | Multiple cursors |
| easyalign | Align text |
| splitjoin | Split/join code blocks |
| todo-comments | Highlight TODOs |
| img-clip | Paste images |
| githubtheme | Color scheme |

## Custom Commands
| Command | Description |
|---------|-------------|
| `:GitDiff [branch]` | Diff against branch |
| `:GitPush "msg"` | Add, commit, push |
| `:GitCommit "msg"` | Add and commit |
| `:GitLog` | Git log graph |
| `:GitStatus` | Git status |
| `:ParseErrors` | Parse errors to quickfix |
| `:Fd [args]` | fd results in quickfix |
| `:Firefox` | Open file in Firefox |

## Notable Keymaps
- `-` Oil file explorer
- `<leader>m` Toggle macro recording
- `<leader>gp/gc/gl/gs` Git shortcuts
- `<C-a>` Select all (returns cursor)
- `<C-c>/<C-v>` Clipboard copy/paste
- `<A-Up/Down>` Move lines
- `cd` Navigate to terminal's path

> Tested on Fedora Linux with i3.
