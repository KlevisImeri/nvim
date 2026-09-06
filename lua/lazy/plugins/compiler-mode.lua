return {
  dir = "/home/klevis/Projects/compile-mode.nvim",
  -- branch = "latest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "m00qek/baleia.nvim" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = function()
      return {
        ansi_color = {
          kind = "render",
          baleia_options = {
            colors = setmetatable({}, {
              __index = function(_, i)
                return vim.g["terminal_color_" .. i]
              end,
            }),
          },
        },
        bang_expansion = true,
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

    local groups = {
      { "CompileModeError",           { fg = "#e06c75" } },
      { "CompileModeWarning",         { fg = "#e5c07b" } },
      { "CompileModeInfo",            { fg = "#56b6c2" } },
      { "CompileModeMessage",         { link = "Normal" } },
      { "CompileModeCommandOutput",   { fg = "#abb2bf" } },
      { "CompileModeMessageRow",      { fg = "#c678dd" } },
      { "CompileModeMessageCol",      { fg = "#c678dd" } },
      { "CompileModeDirectoryMessage",{ fg = "#56b6c2" } },
      { "CompileModeCheckTarget",     { fg = "#abb2bf" } },
      { "CompileModeCheckResult",     { link = "Normal" } },
      { "CompileModeOutputFile",      { fg = "#56b6c2" } },
      { "CompileModeErrorLocus",      { bg = "#3e4451" } },
    }
    for _, item in ipairs(groups) do
      vim.api.nvim_set_hl(0, item[1], item[2])
    end
  end,
}
