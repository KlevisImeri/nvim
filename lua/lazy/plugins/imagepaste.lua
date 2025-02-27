return {
  'img-paste-devs/img-paste.vim',
  config = function()
    vim.g.mdip_imgdir = 'img'
    vim.g.mdip_imgname = 'image'
    vim.cmd [[autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>]]
  end
}
