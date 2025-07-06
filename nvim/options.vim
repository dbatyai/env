set nocompatible

let mapleader = ","
let g:mapleader = ","

let g:python3_host_prog = "/usr/bin/python3"

if executable('rg')
  set grepprg=rg\ --vimgrep\ -S
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

set tags^=./.git/tags;

set history=5000
set scrolloff=7 " Minimum number of line above or below the cursor
set shm+=I "Don't show intro screen
set guicursor=i:block

set mouse=a

if !empty(provider#clipboard#Executable())
  set clipboard+=unnamedplus
endif

if !empty($STY) " Disable mouse support if running in ssh
  set mouse=
  set clipboard=
endif

set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

filetype plugin on
filetype indent on

set ffs=unix,dos,mac
set encoding=utf8

set wildmenu
set wildmode=longest,list
set wildignore=*.o,*~,*.pyc
set completeopt=menuone

set showtabline=2
set laststatus=2
set cmdheight=1
set foldcolumn=1

set switchbuf=useopen,usetab
set hidden " Hide buffer when abandoned
set nobackup
set nowb
set noswapfile
set viminfo='1024,<1000,% "Re-open buffers on startup
set autoread "Auto read when a file is changed from the outside
set autowriteall
set undofile

set updatetime=1000
set timeoutlen=500
set ttimeoutlen=5

set number
set relativenumber
set expandtab " Use spaces instead of tabs
set smarttab " Enable smart tabs
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set cino+=g0 " Don't indent access specifiers
set cino+=l1 " Case label alignment

set linebreak
set breakindent
set showbreak=>
set cpoptions+=n

set textwidth=120
set formatoptions=croqbjmM
set backspace=eol,start,indent
set wrap
set whichwrap+=<,>,h,l
set list
set listchars=tab:➛\ ,trail:·,extends:>,precedes:<,nbsp:+
set matchpairs=(:),{:},[:],<:>

set hlsearch
set smartcase
set ignorecase
set incsearch
set magic " Enable special characters in regex
set showmatch " Show matching brackets
set matchtime=2

set noshowmode
set noerrorbells
set novisualbell
set t_vb=

set lazyredraw " Don't redraw while executing macros

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Config variables
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let c_space_errors = 1

let python_space_error_highlight = 1
let g:pyindent_continue = 4
let g:pyindent_open_paren = 4

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 3
