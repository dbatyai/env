syn match cOps '[+\-*%&|^!=~:]'
syn match cOps '\s/\s'
syn match cParens '[(){}[\]<>]'
syn match cMacroInvoc "\<[0-9A-Z_]\+\>" containedin=cPreCondit
syn match cMemberAccess "\.\|->\|::"
syn match cCommentTag '@\S*' contained containedin=cComment

hi link cOps Operator
hi link cParens Delimiter
hi link cMacroInvoc Constant
hi link cMemberAccess Delimiter
hi link cCommentTag SpecialComment
