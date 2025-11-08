return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0", 
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set


    set({"n", "x"}, "<A-S-Up>", function() mc.lineAddCursor(-1) end, { desc = "Add Cursor Above (VS Code)" })
    set({"n", "x"}, "<A-S-Down>", function() mc.lineAddCursor(1) end, { desc = "Add Cursor Below (VS Code)" })
    set({"n", "x"}, "<A-S-Left>", function() mc.lineSkipCursor(-1) end)
    set({"n", "x"}, "<A-S-Right>", function() mc.lineSkipCursor(1) end)

    set({"n", "x"}, "<C-d>", function() mc.matchAddCursor(1) end, { desc = "Add Cursor to Next Match (VS Code: Ctrl+D)" })
    set({"n", "x"}, "<C-k>d", function() mc.matchSkipCursor(1) end, { desc = "Skip Current Match (VS Code: Ctrl+K,D)" })
    set({"n", "x"}, "<C-S-l>", mc.matchAllAddCursors, { desc = "Select All Matches (VS Code: Ctrl+Shift+L)" })

    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- Disable and enable a single cursor
    set({"n", "x"}, "<c-k>", mc.toggleCursor)

    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one. (Neovim Helper)
      layerSet({"n", "x"}, "<left>", mc.prevCursor)
      layerSet({"n", "x"}, "<right>", mc.nextCursor)

      -- Delete the main cursor. (Neovim Helper)
      layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end, { desc = "Clear Cursors / Enable (VS Code Exit on ESC)" })
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn"})
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
  end
}
