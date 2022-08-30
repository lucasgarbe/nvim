" .vimrc

set nocompatible
set encoding=utf-8 

" vundle plugin

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" 
Plugin 'gmarik/Vundle.vim'
Plugin 'chriskempson/base16-vim' 
" Plugin 'danielwe/base16-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'mike-hearn/base16-vim-lightline'
Plugin 'mattn/emmet-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'mxw/vim-jsx'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'junegunn/fzf', { 'do': { ->fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on

" visuals

if filereadable(expand("~/.vimrc_background"))
  set background=dark
  let base16colorspace=256
  source ~/.vimrc_background
endif

syntax on
set expandtab " tab to spaces
set shiftwidth=2 " number of spaces when shift indenting
set tabstop=2 " number of visual spaces per tab
set softtabstop=2 " number of spaces in tab when editing
set wrap " wrap lines
set smartindent
set autoindent " copy indentation form previous line
set wrap linebreak nolist " wrap lines without line breaks
set linespace=4
set number " show line numbers
set relativenumber
set showmatch " matches brackets
set cursorline " highlights current line
set visualbell " turn off the bell

set noshowmode " no mode shown, redundant with lightline
set laststatus=2 " important for lightline
let g:lightline = {}
let g:lightline.colorscheme='base16_outrun_dark'

" map NERDTree
map <C-n> :NERDTreeToggle<CR> 


" KEY MAPPINGS

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" fzf
nnoremap <C-P> :Files<cr>

" jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" esckey
set timeoutlen=1000 ttimeoutlen=0
