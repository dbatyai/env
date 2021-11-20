"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let g:mapleader = ","

set nocompatible
set nottybuiltin

if &term =~ '^\%(screen\|tmux\)'
  set ttymouse=sgr

  execute "silent! set <xUp>=\<Esc>[@;*A"
  execute "silent! set <xDown>=\<Esc>[@;*B"
  execute "silent! set <xRight>=\<Esc>[@;*C"
  execute "silent! set <xLeft>=\<Esc>[@;*D"
endif

set history=5000
set tags^=./.git/tags;
set scrolloff=7 " Minimum number of line above or below the cursor
set shm+=I "Don't show intro screen

let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

filetype plugin on
filetype indent off

set wildmenu
set wildmode=longest,list
set wildignore=*.o,*~,*.pyc,*/build/*
set completeopt=menuone

set showtabline=2
set laststatus=2
set cmdheight=1
set foldcolumn=1

set switchbuf=useopen,usetab,newtab
set hidden " Hide buffer when abandoned
set nobackup
set nowb
set noswapfile
set viminfo='1024,<1000,% "Re-open buffers on startup
set autoread "Auto read when a file is changed from the outside
set autowriteall

set updatetime=1000
set timeoutlen=500
set ttimeoutlen=5

set number " Line numbers
set expandtab " Use spaces instead of tabs
set smarttab " Enable smart tabs
set shiftwidth=2
set tabstop=2
set noai
set nosi
let c_space_errors = 1
let python_space_error_highlight = 1

set linebreak
set textwidth=120
set formatoptions="croqbj"
set backspace=eol,start,indent
set wrap
set whichwrap+=<,>,h,l

set hlsearch
set smartcase
set ignorecase
set incsearch
set magic " Enable special characters in regex
set showmatch " Show matching brackets
set matchtime=2

set noerrorbells
set novisualbell
set t_vb=

set lazyredraw " Don't redraw while executing macros

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'ap/vim-buftabline'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'tpope/vim-fugitive'
Plugin 'yegappan/grep'
Plugin 'amix/open_file_under_cursor.vim'

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_match_window='min:10,max:10'
let g:ctrlp_line_prefix='  '

Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeFocus<CR>

Plugin 'rhysd/vim-clang-format'
fun! EnableAutoFormat()
  if !empty(findfile('.clang-format', '.;'))
    execute 'ClangFormatAutoEnable'
  else
    execute 'ClangFormatAutoDisable'
  endif
endfun
au FileType c,cc,cpp call EnableAutoFormat()

Plugin 'ycm-core/YouCompleteMe'
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_max_diagnostics_to_display = 100
let g:ycm_confirm_extra_conf = 0
let g:ycm_auto_hover = ''
let g:ycm_clangd_args=['--header-insertion=never']
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '--'
nmap <silent> <leader>d <plug>(YCMHover)
nmap <silent> <leader>D :YcmDiags<CR>
nmap <silent> <leader>f :YcmCompleter FixIt<CR>
nmap <silent> <leader>n :lnext<CR>

Plugin 'rust-lang/rust.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1

Plugin 'itchyny/lightline.vim'
let g:lightline = {
      \   'colorscheme': 'lightlinecolors',
      \   'component': {
      \     'lineinfo': '%4l:%-2v|%4L%<',
      \     'modified': '[%M]',
      \   },
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'], ['readonly', 'modified'], ['filename']
      \     ]
      \   }
      \ }

Plugin 'itchyny/calendar.vim'
let g:calendar_first_day = 'monday'
let g:calendar_date_endian = 'big'
let g:calendar_date_month_name = 1
let g:calendar_date_full_month_name = 1
let g:calendar_week_number = 1
let g:calendar_task = 1
let g:calendar_calendar = 'hungary'

call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable " Enable syntax highlighting

set ffs=unix,dos,mac " Use Unix as the standard file type
set encoding=utf8
set background=dark

try
    colorscheme desert
catch
endtry

hi LineNr      ctermfg=DarkGray  guifg=DarkGray
hi ErrorMsg    ctermfg=DarkRed   ctermbg=None
hi Error       ctermfg=DarkRed   ctermbg=None cterm=Bold,Reverse
hi SignColumn  ctermbg=None

" CtrlP
hi StatusLine  ctermfg=White     ctermbg=None  cterm=None
hi Cursorline  ctermfg=DarkGray  ctermbg=None  cterm=Bold,Reverse

" YCM
hi Pmenu              ctermfg=DarkCyan  ctermbg=Black
hi YcmErrorSection    ctermfg=Black     ctermbg=DarkRed
hi YcmErrorSign       ctermfg=Black     ctermbg=DarkRed
hi YcmWarningSection  ctermfg=Black     ctermbg=DarkBlue
hi YcmWarningSign     ctermfg=Black     ctermbg=DarkBlue

" Tabline
hi TabLine      ctermfg=Gray       ctermbg=None  cterm=None
hi TabLineFill  ctermfg=Gray       ctermbg=None  cterm=None
hi TabLineSel   ctermfg=DarkGreen  ctermbg=None  cterm=bold,reverse

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags
noremap <leader>g <C-]>
noremap <leader>t <C-T>
noremap <C-g> <C-]>

" Buffer management
nnoremap <silent> <M-Left> <Esc>:bp<CR>
nnoremap <silent> <M-Right> <Esc>:bn<CR>
nnoremap <silent> <leader>b :BufExplorer<CR>
nnoremap <silent> <leader>x :Bclose<CR>
nnoremap <silent> <leader>o :%bd <bar> e#<CR>

" Fast saving
nnoremap <leader>w :w!<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Tab management
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext
map <leader>tn :tabnew<cr>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Window movement
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-Up> <C-W>k
noremap <C-Down> <C-W>j
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l

" Text manipulation
nnoremap xx "_dd
nnoremap <S-x> "_D
vnoremap x "_d
vnoremap <S-x> "_D
noremap <silent> <S-Up> <Esc>:m .-2<CR>
noremap <silent> <S-Down> <Esc>:m .+1<CR>

" Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>p :setlocal paste!<cr>

" First non-blank character
map 0 ^

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection()<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :call VisualSelection()<CR>?<C-R>=@/<CR><CR>

" Map <Space> to / (search) and Shift-<Space> to ? (backwards search)
map <space> /
map <S-space> ?

" Clear highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  au FileType gitcommit set viminfo=

  " Delete trailing whitespace when writing buffer contents of certain file types
  au BufWritePre *.txt,*.js,*.ts,*.py,*.wiki,*.sh,*.coffee,*rc,*.vim,*.conf :call CleanExtraSpaces()

  " Return to last edit position when opening files
  au BufReadPost * if &ft !~# 'commit' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" :W sudo saves the file
command! W execute 'silent! w !sudo tee % > /dev/null' <bar> e!

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufferClose()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" Delete buffer without closing window
function! <SID>BufferClose()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   exe "bdelete! ".l:currentBufNum
endfunction

function! VisualSelection() range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
