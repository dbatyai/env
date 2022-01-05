set background=dark

hi clear
if exists("syntax_on")
 syntax reset
endif

let g:colors_name="obscure"

" Syntax
hi Comment cterm=None ctermfg=69
" hi Todo

hi Constant ctermfg=203
hi String ctermfg=172
hi Character ctermfg=99
" hi Number
hi Boolean ctermfg=99
" hi Float

hi Identifier ctermfg=6
" hi Function

hi Statement ctermfg=3
" hi Conditional
" hi Repeat
" hi Label
hi Operator ctermfg=76
" hi Keyword ctermfg=100
" hi Exception

hi Preproc cterm=Bold ctermfg=DarkCyan
" hi Preproc cterm=Bold ctermfg=81
" hi Include
" hi Define
" hi Macro
" hi PreCondit

hi Type ctermfg=40
" hi StorageClass
" hi Structure
" hi Typedef

hi Special ctermfg=135
" hi SpecialChar
hi SpecialComment cterm=Bold ctermfg=Blue
" hi Tag
hi Delimiter ctermfg=74
" hi Debug

hi Underlined cterm=Underline ctermfg=5

hi Ignore cterm=bold ctermfg=DarkGrey

" Tabline
hi TabLine ctermfg=Gray ctermbg=None cterm=None
hi TabLineFill ctermfg=Gray ctermbg=None cterm=None
hi TabLineSel ctermfg=DarkGreen ctermbg=None cterm=Bold,Reverse

" YCM
hi Pmenu ctermfg=DarkCyan ctermbg=Black
hi YcmErrorSection ctermfg=Black ctermbg=DarkRed
hi YcmErrorSign ctermfg=Black ctermbg=DarkRed
hi YcmWarningSection ctermfg=Black ctermbg=DarkBlue
hi YcmWarningSign ctermfg=Black ctermbg=DarkBlue

" Editor
hi StatusLine ctermfg=White ctermbg=None cterm=None
hi Cursorline ctermfg=None ctermbg=None cterm=Bold

hi LineNr ctermfg=DarkGray guifg=DarkGray
hi SignColumn ctermbg=None
hi VertSplit cterm=none
hi NonText cterm=bold ctermfg=DarkBlue
hi SpecialKey ctermfg=DarkGreen

hi Error ctermfg=DarkRed ctermbg=None cterm=Bold,Reverse
hi ErrorMsg ctermfg=DarkRed ctermbg=None
hi WarningMsg ctermfg=1

hi FoldColumn ctermfg=DarkGray ctermbg=None
hi Folded ctermfg=DarkGray ctermbg=None

hi Search cterm=None ctermfg=250 ctermbg=26
hi IncSearch cterm=None ctermfg=Yellow ctermbg=Green
hi MatchParen ctermfg=75 ctermbg=237

hi Question ctermfg=Green
hi MoreMsg ctermfg=DarkGreen
hi ModeMsg cterm=None ctermfg=Brown
hi WildMenu ctermfg=0 ctermbg=3

hi Title ctermfg=5
hi Directory ctermfg=DarkCyan

hi Visual cterm=Reverse
hi VisualNOS cterm=Bold,Underline

" Diff
hi DiffAdd ctermbg=4
hi DiffChange ctermbg=5
hi DiffDelete cterm=Bold ctermfg=4 ctermbg=6
hi DiffText cterm=Bold ctermbg=1
