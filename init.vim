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
noremap <C-c> "+y

" Call the .vimrc.plug file
call plug#begin('~/.vim/plugged')

" Comment and uncomment lines
" Plug 'itchyny/nerdcommenter'

" Color theme
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'vim-airline/vim-airline'
Plug 'https://tpope.io/vim/commentary.git'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()


" Choose theme

" Nightfly
 colorscheme nightfly
" let g:lightline = { 'colorscheme': 'nightfly' }

" Paper
" set t_Co=256   
" set background=light
" colorscheme PaperColor
" " let g:airline_theme='papercolor'
