return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "amarz45/nvim-cmp-buffer-lines",
      "hrsh7th/cmp-path",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-nvim-lua",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "kdheepak/cmp-latex-symbols",
      "petertriho/cmp-git",
      "hrsh7th/cmp-cmdline",
      "kristijanhusak/vim-dadbod-completion",
      "js-everts/cmp-tailwind-colors",
    },
    config = function()
      local cmp = require("cmp")
      local tailwind = require("cmp-tailwind-colors")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(
          0, 
          line - 1, 
          line,
          true
        )[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        window = {
          completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel",
            scrollbar = false, 
            col_offset = -1,
            side_padding = 1,
          },
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel",
            max_width = 80,
            min_width = 40,
            max_height = math.floor(vim.o.lines * 0.3),
          }
        },

        mapping = cmp.mapping.preset.insert({
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),

        sources = cmp.config.sources({
          { name = "treesitter",    group_index = 1 },
          { name = "nvim_lua",      group_index = 2 },
          { name = "path",          group_index = 3 },
          { name = "buffer-lines",  group_index = 4 },
          { name = "buffer",        group_index = 4 },
          { name = "latex_symbols", group_index = 5 },
          { name = "spell",         group_index = 6 },
          { name = "emoji",         group_index = 6 }
        }),

        formatting = {
          fields = { "abbr", "menu" },
          format = function(entry, vim_item)
            tailwind.format(entry, vim_item)

            local source_names = {
              buffer = "[Buffer]",
              ["buffer-lines"] = "[Lines]",
              path = "[Path]",
              treesitter = "[Treesitter]",
              nvim_lua = "[Lua]",
              spell = "[Spell]",
              emoji = "[Emoji]",
              latex_symbols = "[LaTeX]",
              git = "[Git]",
              ["vim-dadbod-completion"] = "[DB]",
            }
            vim_item.menu = source_names[entry.source.name]

            return vim_item
          end,
        },

        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
          { name = "buffer" },
        })
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        })
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
            }
          })
        end
      })

    end,
  }
}
