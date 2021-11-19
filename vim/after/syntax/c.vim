syn match MacroInvoc "\<[0-9A-Z_]\+\>" containedin=cPreCondit
syn match Ops '[+\-*%&|^!=~:]'
syn match Div '\s/\s'
syn match MemberAccess "\.\|->\|::"
syn match Parens '[(){}\[\]<>]'
syn match CommentTag '@\S*' contained containedin=cComment

hi Comment cterm=None ctermfg=69
hi Search ctermfg=250 ctermbg=26
hi MatchParen ctermfg=75 ctermbg=237
hi Constant ctermfg=203
hi Character ctermfg=99
hi Boolean ctermfg=99
hi String ctermfg=172
hi Preproc cterm=bold ctermfg=81
hi Type ctermfg=40
hi Operator ctermfg=76
hi Keyword ctermfg=100
hi Special ctermfg=135
hi Delimiter ctermfg=74
hi SpecialComment cterm=bold ctermfg=Blue

hi link MacroInvoc Constant
hi link Ops Operator
hi link Div Ops
hi link MemberAccess Delimiter
hi link Parens Delimiter
hi link CommentTag SpecialComment
