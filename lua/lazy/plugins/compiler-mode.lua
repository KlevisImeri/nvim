return {
  "ej-shafran/compile-mode.nvim",
  -- version = "^5.0.0",
  -- you can just use the latest version:
  branch = "latest",
  -- or the most up-to-date updates:
  -- branch = "nightly",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
        baleia_setup = true,
        bang_expansion = true,
        -- debug = true,

        environment = {
            CARGO_TERM_COLOR = "always",
        },

        error_regexp_table = {
            rust = {
                regex = "^ *--> \\([^:]\\+\\):\\([0-9]\\+\\):\\([0-9]\\+\\)",
                filename = 1,
                row = 2,
                col = 3,
            },
        },
    }
  end
}
