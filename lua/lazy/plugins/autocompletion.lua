return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      -- Core Completion Sources (LSP source has been removed)
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

      -- Specialized sources
      "kristijanhusak/vim-dadbod-completion",
      "js-everts/cmp-tailwind-colors",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
    config = function()
      local cmp = require("cmp")

      -- Helper function for smart Tab completion
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(
          0, 
          line - 1, 
          line,
          true
        )[1]:sub(col, col):match("%s") == nil
      end
      
      -- Helper for Tailwind CSS formatting
      local format_plugins = {
        tailwind = require("cmp-tailwind-colors"),
        colorizer = require("tailwindcss-colorizer-cmp.nvim").formatter
      }
      
      cmp.setup({
        -- Window appearance with Telescope-style borders
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

        -- Key Mappings
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),

        -- Completion sources with priority (nvim_lsp removed)
        sources = cmp.config.sources({
          { name = "treesitter", group_index = 1 },
          { name = "nvim_lua", group_index = 2 },
          { name = "path", group_index = 3 },
          { name = "buffer-lines", group_index = 4 },
          { name = "buffer", group_index = 4 },
          { name = "latex_symbols", group_index = 5 },
          { name = "spell", group_index = 6 },
          { name = "emoji", group_index = 6 },
        }),

        -- Simplified formatting for the completion menu (no lspkind)
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            -- Add Tailwind CSS color previews
            format_plugins.tailwind.format(entry, vim_item)

            -- Add a menu label for the source
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
            
            -- Kind icons will now be text-based, handled by cmp default
            -- vim_item.kind = -- Text-based kind will show here automatically

            return vim_item
          end,
        },

        -- Sorting rules for completion items
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

      -- Specialized setups for different contexts
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

      -- Autocommand for SQL database completion
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
  },

  -- Auto pairs integration (highly recommended with nvim-cmp)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function ()
        require("nvim-autopairs").setup()
        -- important for cmp integration
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("cmp").event:on(
          "confirm_done",
          cmp_autopairs.on_confirm_done()
        )
    end
  },
}
