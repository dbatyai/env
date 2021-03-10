"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version: 
"       6.0 - 01/04/17 14:24:34 
"
" Blog_post: 
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version: 
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-scripts/bufexplorer.zip'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeFocus<CR>

Plugin 'amix/open_file_under_cursor.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mkitt/tabline.vim'
Plugin 'ap/vim-buftabline'
Plugin 'codota/tabnine-vim'

Plugin 'rust-lang/rust.vim'
" Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
let g:typescript_indent_disable = 1

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
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Re-open buffers on startup
set viminfo='1024,<1000,%

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent off

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

set tags^=./.git/tags;

autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu
set wildmode=longest,list

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

set number
hi LineNr ctermfg=DarkGray

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set textwidth=120
set formatoptions="croqbj"

set noai "Auto indent
set nosi "Smart indent
filetype indent off
set wrap "Wrap lines

let c_space_errors = 1
let python_space_error_highlight = 1

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
:set cmdheight=1

" Always show the status line
set laststatus=2
let w:winenabled=1

function! StatuslineMode()
  let enabled = get(w:, 'winenabled', 0)
  if !l:enabled == 1
    hi User1 cterm=bold ctermbg=DarkGray ctermfg=LightGray
    return "NORMAL"
  endif

  let m = mode()
  if m == "v" || m == "V" || m == "CTRL-V" || m == ""
    hi User1 cterm=bold ctermbg=Yellow ctermfg=Red
    return "VISUAL"
  elseif m == "i" || m == "R"
    hi User1 cterm=bold ctermbg=Blue ctermfg=White
    return "INSERT"
  else
    hi User1 cterm=bold ctermbg=DarkGreen ctermfg=White
    return "NORMAL"
  endif
endfunction

autocmd WinLeave * let w:winenabled=0
autocmd WinEnter * let w:winenabled=1

hi User1 cterm=bold ctermbg=DarkGreen ctermfg=White
hi User2 ctermfg=White ctermbg=Black
hi User3 cterm=bold ctermfg=DarkRed ctermbg=Black
hi User4 cterm=bold ctermfg=DarkGray ctermbg=Black
hi User5 cterm=bold ctermfg=LightGray ctermbg=Black
hi ErrorMsg ctermfg=Red ctermbg=Black
hi Error ctermfg=Black ctermbg=Red

" Format the status line
set statusline=
set statusline+=%#User1#
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=\ 
set statusline+=%#User3#
set statusline+=\ %m%r\ 
set statusline+=%#User2#
set statusline+=%<
set statusline+=%F
set statusline+=%=
set statusline+=%#User4#
set statusline+=\ %l:%c/%L\ 
set statusline+=%#User5#
set statusline+=\ %{&ft}\ \|\ %{&fenc}\ \|\ %{&fileformat}\ 

hi TabLine      ctermfg=Gray  ctermbg=Black     cterm=NONE
hi TabLineFill  ctermfg=Gray  ctermbg=Black     cterm=NONE
hi TabLineSel   ctermfg=Green  ctermbg=Black  cterm=bold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

map [1;3D <M-Left>
map [1;3C <M-Right>
map [1;3A <M-Up>
map [1;3B <M-Down>
map [1;5D <C-Left>
map [1;5C <C-Right>
map [1;5A <C-Up>
map [1;5B <C-Down>

map OD <M-Left>
map OC <M-Right>
map OA <M-Up>
map OB <M-Down>
imap Od <C-Left>
imap Oc <C-Right>
imap Oa <C-Up>
imap Ob <C-Down>
map Od <C-Left>
map Oc <C-Right>
map Oa <C-Up>
map Ob <C-Down>
map [a <S-Up>
map [b <S-Down>
map [c <S-Right>
map [d <S-Left>

map <leader>g <C-]>
map <leader>t <C-T>
noremap <C-g> <C-]>
noremap g <C-]>
noremap t <C-T>

nnoremap <silent> <M-Home> :BufExplorer<CR>
nnoremap <silent> <M-Left> <Esc>:bp<CR>
nnoremap <silent> <M-Right> <Esc>:bn<CR>
noremap <C-Left> <Esc>b
noremap <C-Right> <Esc>w
" Move a line of text using ALT+[jk] or Command+[jk] on mac
noremap <C-Down> <Esc>:m .+1<CR>
noremap <C-Up> <Esc>:m .-2<CR>
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" /vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

nnoremap x "_d

map <leader>b <Esc>:Bclose<CR>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.ts,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
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

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
