hi Comment cterm=bold ctermfg=69
hi Search ctermfg=250 ctermbg=26
hi MatchParen ctermfg=75 ctermbg=237
hi Constant ctermfg=167
hi Character ctermfg=99
hi Boolean ctermfg=99
hi String ctermfg=172
hi Preproc cterm=bold ctermfg=81
hi Type ctermfg=40
hi Operator ctermfg=76
hi Keyword ctermfg=100
hi Special ctermfg=135
hi MacroInvoc ctermfg=203
syn match MacroInvoc "\<[A-Z][0-9A-Z_]*\>" containedin=cPreCondit
syn match Ops '[&*|^+\-*=!]\|\s/\s'
hi link Ops Operator
syn match MemberAccess "->\|::\|\."
hi MemberAccess ctermfg=74
syn match Parens '[(){}\[\]<>]'
hi Parens ctermfg=74
