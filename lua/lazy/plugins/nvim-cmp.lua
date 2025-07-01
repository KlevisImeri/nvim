return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",

      -- Text-based completion sources
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lua",
      "andersevenrud/cmp-tmux",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-emoji",
      "kdheepak/cmp-latex-symbols",
      "lukas-reineke/cmp-rg",
      "petertriho/cmp-git",
      "dmitmel/cmp-cmdline-history",
      "hrsh7th/cmp-calc",

      -- AI-Powered Completion with cmp-ai (Ollama)
      {
        "tzachar/cmp-ai",
        dependencies = "nvim-lua/plenary.nvim",
      },

      -- UI Enhancements
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
          max_item_count = 10,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                treesitter = "[Treesitter]",
                tmux = "[TMUX]",
                nvim_lua = "[Lua]",
                spell = "[Spell]",
                emoji = "[Emoji]",
                calc = "[Calc]",
                latex_symbols = "[LaTeX]",
                git = "[Git]",
                rg = "[Ripgrep]",
                pandoc = "[Pandoc]",
                cmp_ai = "[AI]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"]  = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-l>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "treesitter" },
          { name = "tmux" },
          { name = "nvim_lua" },
          { name = "spell" },
          { name = "emoji" },
          { name = "calc" },
          { name = "latex_symbols" },
          { name = "git" },
          -- { name = "rg" },
          { name = "pandoc" },
          { name = "cmp_calc"},
          -- { name = "cmp_ai" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
          { name = "cmdline_history" },
        }),
      })

      require("luasnip.loaders.from_vscode").lazy_load()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Setup cmp-ai with Ollama using the qwen2.5-coder:1.5b model
      local cmp_ai = require("cmp_ai.config")
      cmp_ai:setup({
        max_lines = 100,
        provider = "Ollama",
        provider_options = {
          model = "qwen2.5-coder:1.5b",
          prompt = function(lines_before, lines_after)
            return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
          end,
        },
        notify = true,
        notify_callback = function(msg)
          vim.notify(msg)
        end,
        run_on_every_keystroke = false,
      })

    end,
  },

  -- Additional Plugins for Enhanced Completions
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "onsails/lspkind.nvim",
    lazy = true,
  },
}
