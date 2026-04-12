return {
  name = "tapi",
  event = "TermEnter",

  config = function()
    function _G.Tapi_cd(_, args)
      if args and args[1] then
        vim.cmd.cd(args[1])
      end
    end
  end,
}
