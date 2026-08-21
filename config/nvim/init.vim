" ============================================================
" Basic Configuration
" ============================================================
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set nocompatible          " no-op in nvim, needed in vim to leave vi-compatible mode

" Quality-of-life defaults (previously missing)
set hlsearch               " highlight search matches
set incsearch              " show matches as you type
set ignorecase smartcase   " case-insensitive unless a capital is typed
set mouse=a                " mouse support in all modes
set splitbelow splitright  " more intuitive split direction
set scrolloff=8            " keep context above/below cursor
set updatetime=300          " faster CursorHold / gitgutter updates
set signcolumn=yes          " stop gitgutter causing text to jump

" clipboard / termguicolors aren't guaranteed to be compiled in on every
" vim build, so guard them instead of assuming (nvim always has both)
if has('clipboard')
  set clipboard=unnamedplus
endif
if has('termguicolors')
  set termguicolors          " required for gruvbox to render correctly
endif

" persistent undo — vim needs an explicit, existing undodir;
" nvim already defaults to a sane one, but this keeps both in sync
let s:undodir = expand('~/.vim/undodir')
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
let &undodir = s:undodir
set undofile

let mapleader = " "

" ============================================================
" Language-specific settings
" Grouped in an augroup with 'autocmd!' so re-sourcing this
" file doesn't stack duplicate autocmds.
" ============================================================
augroup filetype_settings
  autocmd!
  autocmd BufNewFile,BufRead *.py
        \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
  autocmd BufNewFile,BufRead *.go
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
  autocmd BufNewFile,BufRead *.scala,*.java
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
  autocmd BufNewFile,BufRead *.js,*.html,*.css
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab fileformat=unix
augroup END

" ============================================================
" Plugin Manager (Vundle)
" ============================================================
filetype off

" Vundle lives in a different place depending on editor — clone
" VundleVim/Vundle.vim into whichever of these applies to you.
if has('nvim')
  set rtp+=~/.config/nvim/bundle/Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'
Plugin 'jpalardy/vim-slime'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'morhetz/gruvbox'

Plugin 'davidhalter/jedi-vim'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'carlsmedstad/vim-bicep'
Plugin 'hashivim/vim-terraform'

Plugin 'chrisbra/csv.vim'
Plugin 'elzr/vim-json'

call vundle#end()

filetype plugin indent on

" ============================================================
" Theme
" ============================================================
set background=dark
colorscheme gruvbox

" ============================================================
" Airline
" ============================================================
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = '℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ':'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.dirty = '⚡'
let g:airline#extensions#tabline#enabled = 0   " was '#enables', a typo — the real option name is '#enabled'
let g:airline_theme = 'monochrome'

" ============================================================
" NERDTree
" ============================================================
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "~"

" ============================================================
" Vim-Slime
" ============================================================
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}

" ============================================================
" Go
" ============================================================
augroup go_settings
  autocmd!
  autocmd FileType go inoremap <buffer> . .<C-x><C-o>
augroup END

" ============================================================
" Python
" ============================================================
" python3_host_prog is a Neovim-only setting (used for Python plugin
" host / providers); vim ignores it, so guard it for clarity.
if has('nvim')
  let g:python3_host_prog = "$HOME/Development/python-dev/bin/python"
endif
