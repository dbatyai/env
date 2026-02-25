"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => StatusLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi StatusLine           cterm=None ctermfg=none    ctermbg=None  gui=none guifg=none    guibg=none
hi StatusLineNormal     cterm=None ctermfg=black   ctermbg=76    gui=bold guifg=#000000 guibg=#5fd700
hi StatusLineInsert     cterm=None ctermfg=black   ctermbg=75    gui=bold guifg=#000000 guibg=#5fafff
hi StatusLineVisual     cterm=None ctermfg=black   ctermbg=214   gui=bold guifg=#000000 guibg=#ffaf00
hi StatusLineReplace    cterm=None ctermfg=black   ctermbg=203   gui=bold guifg=#000000 guibg=#ff5f5f
hi StatusLineCommand    cterm=None ctermfg=black   ctermbg=142   gui=bold guifg=#000000 guibg=#e7c730
hi StatusLineFlags      cterm=None ctermfg=203     ctermbg=None  gui=none guifg=#ff5f5f guibg=none
hi StatusLinePercent    cterm=None ctermfg=235     ctermbg=248   gui=none guifg=#262626 guibg=#a8a8a8
hi StatusLineLocation   cterm=None ctermfg=248     ctermbg=238   gui=none guifg=#a8a8a8 guibg=#262626

hi StatusLineNC         cterm=None ctermfg=DarkGray ctermbg=None gui=none guifg=DarkGray guibg=None
hi StatusLineFlagsNC    cterm=None ctermfg=DarkGray ctermbg=None gui=none guifg=DarkGray guibg=None
hi StatusLinePercentNC  cterm=None ctermfg=235     ctermbg=248   gui=none guifg=#262626  guibg=#a8a8a8
hi StatusLineLocationNC cterm=None ctermfg=248     ctermbg=238   gui=none guifg=#a8a8a8  guibg=#262626

let g:sl_modemap = {
    \ 'n': 'Normal',
    \ 'i': 'Insert',
    \ 'R': 'Replace',
    \ 'v': 'Visual',
    \ 'V': 'Visual',
    \ "\<c-v>": 'Visual',
    \ 's': 'Visual',
    \ 'S': 'Visual',
    \ "\<c-s>": 'Visual',
    \ 'c': 'Command',
    \ 'r': 'Command',
    \ 't': 'Command',
    \ '!': 'Command',
  \}

fun! StatusLineColor(name)
  return '%#StatusLine'.a:name.(g:statusline_winid ==# win_getid() ? '' : 'NC').'#'
endf

fun! StatusLineMode()
  let l:mode=get(g:sl_modemap, mode(), '')
  return StatusLineColor(l:mode).(g:statusline_winid ==# win_getid() ? ' '.toupper(l:mode).' ' : '').(&paste ? '| PASTE ' : '').'%*'
endf

fun! StatusLineFlags()
  return StatusLineColor('Flags').'%h%w%r%m%*'
endf

fun! StatusLineLocation()
  return StatusLineColor('Percent').' %3p%% '.StatusLineColor('Location').' %4l:%-2c | %L '
endf

fun! StatusLine()
  return StatusLineMode().' %t '.StatusLineFlags().'%=%{&fileformat} | %{&encoding} | %{!empty(&ft) ? &ft : "none"} '.StatusLineLocation()
endf

set statusline=%!StatusLine()
