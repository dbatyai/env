set background=dark

hi clear
if exists("syntax_on")
 syntax reset
endif

let g:colors_name="obscure"

hi Normal cterm=none ctermfg=none ctermbg=none gui=none guifg=none guibg=none

hi Comment cterm=none ctermfg=69 ctermbg=none gui=none guifg=#5f87ff guibg=none
hi SpecialComment cterm=bold ctermfg=blue ctermbg=none gui=bold guifg=#4075de guibg=none
hi Todo cterm=bold ctermbg=yellow ctermfg=black gui=bold guibg=yellow guifg=black

hi Constant cterm=none ctermfg=203 ctermbg=none gui=none guifg=#ff5f5f guibg=none
hi String cterm=none ctermfg=172 ctermbg=none gui=none guifg=#d78700 guibg=none
hi Character cterm=none ctermfg=99 ctermbg=none gui=none guifg=#875fff guibg=none
" hi Number
hi Boolean cterm=none ctermfg=99 ctermbg=none gui=none guifg=#875fff guibg=none
" hi Float

hi Identifier cterm=none ctermfg=cyan ctermbg=none gui=none guifg=#70d0f0 guibg=none
" hi Function

hi Statement cterm=none ctermfg=darkyellow ctermbg=none gui=none guifg=#e7c730 guibg=none
" hi Conditional
" hi Repeat
" hi Label
hi Operator cterm=none ctermfg=76 ctermbg=none gui=none guifg=#5fd700 guibg=none
" hi Keyword ctermfg=100
" hi Exception

hi Preproc cterm=bold ctermfg=darkcyan ctermbg=none gui=bold guifg=#20afde guibg=none
" hi Preproc cterm=bold ctermfg=81
" hi Include
" hi Define
" hi Macro
" hi PreCondit

hi Type cterm=none ctermfg=40 ctermbg=none gui=none guifg=#00d700 guibg=none
" hi StorageClass
" hi Structure
" hi Typedef

hi Special cterm=none ctermfg=135 ctermbg=none gui=none guifg=#af5fff guibg=none
" hi SpecialChar
" hi Tag
hi Delimiter cterm=bold ctermfg=74 ctermbg=none gui=bold guifg=#5fafd7 guibg=none
" hi Debug

hi Underlined cterm=Underline ctermfg=5

hi Ignore cterm=bold ctermfg=darkgrey ctermbg=none gui=bold guifg=#767676 guibg=none

" Editor
hi LineNr cterm=none ctermfg=242 ctermbg=none gui=none guifg=#6c6c6c guibg=none
hi SignColumn cterm=none ctermbg=none gui=none guibg=none
hi FoldColumn cterm=none ctermfg=darkgray ctermbg=none gui=none guifg=#767676 guibg=none
hi Folded cterm=none ctermfg=darkgray ctermbg=none gui=none guifg=#767676 guibg=none
hi Cursorline ctermfg=none ctermbg=none cterm=bold
hi VertSplit cterm=none gui=none
hi Title cterm=bold ctermfg=darkcyan ctermbg=none gui=bold guifg=#20afde guibg=none
hi Directory ctermfg=darkcyan guifg=#20afde
hi NonText cterm=none ctermfg=darkgray
hi SpecialKey ctermfg=darkgreen guifg=#00af00
hi Conceal ctermfg=darkgray guifg=#767676

hi Error cterm=bold,reverse ctermfg=darkred ctermbg=none gui=bold,reverse guifg=#ff5f5f guibg=none
hi ErrorMsg ctermfg=darkred ctermbg=none gui=none guifg=#ff5f5f guibg=none
hi WarningMsg ctermfg=darkyellow ctermbg=none gui=none guifg=#e7c730 guibg=none
hi ModeMsg cterm=none ctermfg=darkyellow
hi MoreMsg ctermfg=green guifg=green
hi Question ctermfg=green guifg=green

hi Visual cterm=reverse ctermfg=none ctermbg=none gui=reverse guifg=none guibg=none
hi Pmenu cterm=none ctermfg=darkcyan ctermbg=black gui=none guifg=#20afde guibg=black
hi PmenuSel cterm=reverse ctermfg=none ctermbg=none
hi NormalFloat cterm=none ctermfg=blue ctermbg=236 gui=none guifg=#5f87ff guibg=#1c1c1c
hi WildMenu cterm=none ctermfg=none ctermbg=3

hi BufferCurrent cterm=bold,reverse ctermfg=green ctermbg=none gui=bold,reverse guifg=#37c030 guibg=none
hi BufferCurrentMod cterm=bold,reverse ctermfg=yellow ctermbg=none gui=bold,reverse guifg=#e7c730 guibg=none
hi BufferInactive cterm=none ctermfg=darkgray ctermbg=none gui=none guifg=#888888 guibg=none
hi BufferInactiveMod cterm=bold ctermfg=yellow ctermbg=none gui=bold guifg=#e7c730 guibg=none
hi BufferTabpageFill cterm=none ctermfg=none ctermbg=none gui=none guifg=none guibg=none
hi BufferTabpages cterm=bold ctermfg=red ctermbg=none gui=bold guifg=#ff5f5f guibg=none
hi BufferTabpagesSep cterm=bold ctermfg=gray ctermbg=none gui=bold guifg=gray guibg=none

hi TabLine cterm=none ctermfg=none ctermbg=none gui=none guifg=none guibg=none
hi TabLineFill cterm=none ctermfg=none ctermbg=none gui=none guifg=none guibg=none
hi TabLineSel cterm=bold,reverse ctermfg=green ctermbg=none gui=bold,reverse guifg=#37c030 guibg=none

hi Search cterm=none ctermfg=none ctermbg=240 gui=none guifg=none guibg=#878787
hi IncSearch cterm=none ctermfg=white ctermbg=darkgreen gui=none guifg=white guibg=#37c030
hi CurSearch cterm=none ctermfg=none ctermbg=darkgrey gui=none guifg=none guibg=#878787
hi MatchParen ctermfg=75 ctermbg=237 guifg=#4f7fff guibg=#3a3a3a
hi QuickFixLine ctermfg=none ctermbg=235

hi DiffAdd cterm=bold ctermfg=black ctermbg=darkgreen
hi DiffChange ctermfg=black ctermbg=darkgray
hi DiffDelete ctermfg=black ctermbg=darkred
hi DiffText cterm=bold ctermfg=black ctermbg=darkblue

hi YcmErrorSection ctermfg=black ctermbg=darkred
hi YcmErrorSign ctermfg=black ctermbg=darkred
hi YcmWarningSection ctermfg=black ctermbg=darkblue
hi YcmWarningSign ctermfg=black ctermbg=darkblue
