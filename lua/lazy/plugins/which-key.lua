return {
    'folke/which-key.nvim',
    event = 'VeryLazy', 
    config = function() 
      require('which-key').setup()
      require('which-key').add {
        {'<leader>c', desc = '[C]ode', },
        {'<leader>d', desc = '[D]ocument', },
        {'<leader>r', desc = '[R]ename', },
        {'<leader>s', desc = '[S]earch', },
        {'<leader>w', desc = '[W]orkspace', },
      }
    end,
}
