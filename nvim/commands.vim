"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
  " Delete trailing whitespace when writing buffer contents of certain file types
  au BufWritePre * :call RemoveTrailingSpaces()

  " Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  au BufLeave * :call <SID>BufferPrune()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space
fun! RemoveTrailingSpaces()
  if (&ft=="diff" || &ft=="patch" || &ft=="gitsendemail")
    return
  endif

  let l:save_cursor = getpos(".")
  keepp %s/\s\+$//e
  silent! execute prevnonblank('$') + 1 . ',$delete _'
  call setpos('.', l:save_cursor)
endfun

fun! <SID>BufferPrune()
  let l:buf = bufnr("%")
  if getbufvar(l:buf, "&mod") == 0 && empty(bufname(l:buf))
    set nobuflisted
  endif
endfun

fun! VisualSelection() range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")

  let @/ = l:pattern
  let @" = l:saved_reg
endfun
