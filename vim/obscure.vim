set background=dark

hi clear
if exists("syntax_on")
 syntax reset
endif

let g:colors_name="obscure"

" Syntax
hi Comment cterm=None ctermfg=69
hi Todo cterm=bold ctermbg=Yellow ctermfg=Black

hi Constant ctermfg=203
hi String ctermfg=172
hi Character ctermfg=99
" hi Number
hi Boolean ctermfg=99
" hi Float

hi Identifier ctermfg=6
" hi Function

hi Statement ctermfg=3 cterm=None gui=None
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
hi Pmenu cterm=None ctermfg=DarkCyan ctermbg=Black
hi PmenuSel cterm=reverse ctermfg=none ctermbg=none
hi NormalFloat ctermfg=Blue ctermbg=236

hi YcmErrorSection ctermfg=Black ctermbg=DarkRed
hi YcmErrorSign ctermfg=Black ctermbg=DarkRed
hi YcmWarningSection ctermfg=Black ctermbg=DarkBlue
hi YcmWarningSign ctermfg=Black ctermbg=DarkBlue

" Editor
hi StatusLine ctermfg=White ctermbg=None cterm=None
hi Cursorline ctermfg=None ctermbg=None cterm=Bold

hi LineNr ctermfg=DarkGray guifg=DarkGray
hi SignColumn ctermbg=None
hi VertSplit cterm=None
hi NonText cterm=None ctermfg=DarkGray
hi SpecialKey ctermfg=DarkGreen

hi Error ctermfg=DarkRed ctermbg=None cterm=Bold,Reverse
hi ErrorMsg ctermfg=DarkRed ctermbg=None
hi WarningMsg ctermfg=DarkYellow ctermbg=None

hi FoldColumn ctermfg=DarkGray ctermbg=None
hi Folded ctermfg=DarkGray ctermbg=None

hi Search cterm=None ctermfg=None ctermbg=240
hi IncSearch cterm=None ctermfg=White ctermbg=DarkGreen
hi CurSearch cterm=None ctermfg=None ctermbg=DarkGrey
hi MatchParen ctermfg=75 ctermbg=237
hi QuickFixLine ctermfg=None ctermbg=235

hi Question ctermfg=Green
hi MoreMsg ctermfg=DarkGreen
hi ModeMsg cterm=None ctermfg=Brown
hi WildMenu ctermfg=0 ctermbg=3

hi Title ctermfg=5
hi Directory ctermfg=DarkCyan

hi Visual cterm=Reverse ctermfg=None ctermbg=None
hi VisualNOS cterm=Bold,Underline

" Diff
hi DiffAdd cterm=Bold ctermfg=Black ctermbg=DarkGreen
hi DiffChange ctermfg=Black ctermbg=DarkGray
hi DiffDelete ctermfg=Black ctermbg=DarkRed
hi DiffText cterm=Bold ctermfg=Black ctermbg=DarkBlue
