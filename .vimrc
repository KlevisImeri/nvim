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


" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif

" Choose theme

" Nightfly
 colorscheme nightfly
" let g:lightline = { 'colorscheme': 'nightfly' }

" Paper
" set t_Co=256   
" set background=light
" colorscheme PaperColor
" " let g:airline_theme='papercolor'
