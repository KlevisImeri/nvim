return {
    'numToStr/Comment.nvim',
    lazy = false,
	config = function()
        require('Comment').setup({
			toggler = {
				---Line-comment toggle keymap
				line = '<C-_>',
				---Block-comment toggle keymap
				block = 'gbc',
			},
			opleader = {
	    	    ---Line-comment keymap
    	    	line = '<C-_>',
	    	    ---Block-comment keymap
    	    	block = 'gb',
		    },
		})
	end
}

