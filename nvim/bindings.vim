"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <C-g> <C-]>

" Buffer management
nnoremap <silent> <M-Left> <esc>:bp<cr>
nnoremap <silent> <M-Right> <esc>:bn<cr>
nnoremap <silent> <leader>x <cmd>bprevious <bar> bdelete #<cr>
nnoremap <silent> <leader>e :enew<cr>
nnoremap <silent> <leader>X :%bd <bar> e# <bar> bd# <cr>
nnoremap <silent> <M-Up> <esc>:tabnext<cr>
nnoremap <silent> <M-Down> <esc>:tabprevious<cr>

" Window movement
noremap <C-Up> <C-W>k
noremap <C-Down> <C-W>j
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l

" Window splitting
noremap <leader>v :vsplit<CR>
noremap <leader>s :split<CR>

" Text manipulation
nnoremap x "_d
nnoremap xx "_dd
nnoremap <S-x> "_D
vnoremap x "_d
vnoremap <S-x> "_D
vnoremap > >gv
vnoremap < <gv
nnoremap <leader>y yiw

noremap <silent> <S-Up> <Esc>:m .-2<CR>
noremap <silent> <S-Down> <Esc>:m .+1<CR>

" Toggle paste mode on and off
nnoremap <leader>p :setlocal paste!<cr>

" First non-blank character
nnoremap 0 ^

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection()<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :call VisualSelection()<CR>?<C-R>=@/<CR><CR>

" Visual mode sort lines
vnoremap <silent> s :sort<CR>

nnoremap <silent> <leader><cr> :noh<cr>

nnoremap <silent> <leader>w :silent! write !sudo -S dd bs=1K of=% <cr>
