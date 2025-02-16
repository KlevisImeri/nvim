return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "kdheepak/cmp-latex-symbols",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-emoji",
    "octaltree/cmp-look",

    "hrsh7th/cmp-cmdline",
    "kristijanhusak/vim-dadbod-completion",
    "petertriho/cmp-git",
    "hrsh7th/cmp-buffer",

    "onsails/lspkind.nvim",
    "js-everts/cmp-tailwind-colors",
    "roobert/tailwindcss-colorizer-cmp.nvim",
    "garymjr/nvim-snippets",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- Load advanced snippet collections
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load()

    -- Context-aware completion enabling
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- Multi-source formatting configuration
    local format_plugins = {
      tailwind = require("cmp-tailwind-colors"),
      colorizer = require("tailwindcss-colorizer-cmp").formatter
    }

    cmp.setup({

      performance = {
        debounce = 50,
        throttle = 30,
        fetching_timeout = 100,
        async_budget = 5,
      },

      enabled = function()
        -- Disable in specific contexts
        local context = require("cmp.config.context")
        return not (
          context.in_treesitter_capture("comment") == true or
          context.in_syntax_group("Comment") or
          vim.bo.buftype == "prompt"
        )
      end,

      preselect = cmp.PreselectMode.Item,
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel",
          scrollbar = true,
          col_offset = -1,
          side_padding = 1,
        },
        documentation = {
          max_width = 80,
          min_width = 40,
          max_height = math.floor(vim.o.lines * 0.3),
        }
      },

      view = {
        entries = {
          name = "custom",
          selection_order = "near_cursor",
          follow_cursor = true,
        },
      },

      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      }),

      sources = cmp.config.sources({
        { name = "treesitter", group_index = 1 },
        { name = "nvim_lua", group_index = 2 },        
        { name = "luasnip", group_index = 2 },        
        { name = "path", group_index = 3 },
        { name = "latex_symbols", group_index = 4 },
        { name = "spell", group_index = 5 },
        { name = "emoji", group_index = 5 },
      }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          preset = "codicons",
          maxwidth = 40,
          ellipsis_char = "…",
          before = function(entry, vim_item)
            format_plugins.tailwind.format(entry, vim_item)
            -- format_plugins.colorizer.format(entry, vim_item)

            local icons = {
              Text = "",
              Method = "",
              Function = "󰊕",
              Constructor = "",
              Field = "",
              Variable = "󰀫",
              Class = "",
              Interface = "",
              Module = "󰏗",
              Property = "",
              Unit = "",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              Type = "𝕋",
              TypeParameter = "",
              Namespace = "󰌗",
              Package = "",
              Boolean = "󰨙",
              Array = "󰅪",
              Object = "󰅩",
              Key = "󰌆",
              Null = "󰟢",
              Number = "󰎠",
              String = "󰉾",
              TypeAlias = "",
              Parameter = "󰊄",
              KeywordRepeat = "",
            }

            vim_item.kind = string.format("%s", icons[vim_item.kind])

            local source_names = {
              treesitter = "[ts]",
              nvim_lua = "[lua]",
              luasnip = "[snip]",
              path = "[path]",
              latex_symbols = "[latex]",
              spell = "[spell]",
              emoji = "[emoji]",
              git = "[git]",
              buffer = "[buffer]",
              cmdline = "[cmd]",
              ["vim-dadbod-completion"] = "[db]",
            }
            vim_item.menu = source_names[entry.source.name] or "[" .. (entry.source.name:gsub("^cmp%-", "")) .. "]"

            return vim_item
          end
        })
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

    -- Specialized completions
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "buffer" },
      })
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      })
    })

    -- Database completion
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

  end
}
