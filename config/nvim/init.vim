" Basic Configurations
:set number
:set autoindent
:set relativenumber
:set tabstop=4

" Language Specifics
" Python
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix

" Go
au BufNewFile,BufRead *.go set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix

" Scala
au BufNewFile,BufRead *.scala,*.java set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix

" Web Development
au BufNewFile,BufRead *.js,*.html,*.css set tabstop=2 softtabstop=2 shiftwidth=2 fileformat=unix

" Init Plugin Manager
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim

" Install Plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jpalardy/vim-slime'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ellisonleao/gruvbox.nvim'

Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'fatih/vim-go'
Plugin 'scalameta/nvim-metals'
Plugin 'leafgarland/typescript-vim'
Plugin 'carlsmedstad/vim-bicep'
Plugin 'hashivim/vim-terraform'
Plugin 'mattn/emmet-vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'chrisbra/csv.vim'
Plugin 'elzr/vim-json'

Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on

" Theme
set background=dark
colorscheme gruvbox

" Airline
if !exists('g:airline_symbols')
                let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = '℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ':'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.dirty='⚡'
let g:airline#extensions#tabline#enables = 1
let g:airline_theme='monochrome'

" NERDTree
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Vim-Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}

" Go
au filetype go inoremap <buffer> . .<C-x><C-o>

" Python
let g:python3_host_prog = "$HOME/Development/python-dev/bin/python"
