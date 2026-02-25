syn match cOps '[+\-*%&|^!=~]'
syn match cOps '\s/\s'
syn match cParens '[(){}[\]<>]' containedin=cParen,cBracket
syn match cMacroInvoc "\<[0-9A-Z_]\+\>" containedin=cPreCondit
syn match cMemberAccess "\.\|->\|::"
syn match cCommentTag '@\S*' contained containedin=cComment
syn keyword cOffsetof offsetof

hi link cOffsetof Operator
hi link cOps Operator
hi link cParens Delimiter
hi link cMacroInvoc Constant
hi link cMemberAccess Delimiter
hi link cCommentTag SpecialComment
