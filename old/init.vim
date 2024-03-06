luafile init.lua


" Set compatibility to Vim only"
set nocompatible
" Automatically wrap text
set wrap
" Encoding 
set encoding=utf-8
" Show line nubmers
set number
" Status bar
set laststatus=2
" For the theme
set termguicolors
" The indenting after {
set shiftwidth=3
set tabstop=3
" Easy number navigation
set relativenumber
" Mouse input
set mouse=a
" Shourcuts
inoremap jj <esc>
vmap // :s/^/\/\//<CR>
vmap //r :s/^\/\///<CR>
nnoremap <F5> :!r.bat <CR>
inoremap <C-c> "+y


call plug#begin('~/.vim/plugged')
call plug#end()

