"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

try
  colorscheme obscure
catch
  hi LineNr      ctermfg=DarkGray  guifg=DarkGray
  hi FoldColumn  ctermbg=None
  hi SignColumn  ctermbg=None
  hi Error       ctermfg=DarkRed   ctermbg=None cterm=Bold,Reverse
  hi ErrorMsg    ctermfg=DarkRed   ctermbg=None cterm=None
  hi WarningMsg  ctermfg=DarkYellow  ctermbg=None cterm=None

  hi TabLine      ctermfg=Gray       ctermbg=None  cterm=None
  hi TabLineFill  ctermfg=Gray       ctermbg=None  cterm=None
  hi TabLineSel   ctermfg=DarkGreen  ctermbg=None  cterm=Bold,Reverse
endtry
