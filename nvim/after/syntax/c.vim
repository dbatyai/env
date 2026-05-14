syn match cOps '[+\-*%&|^!=~]'
syn match cOps '\s/\s'
syn match cParens '[(){}[\]<>]' containedin=cParen,cBracket
syn match cMemberAccess "\.\|->\|::"
syn match cCommentTag '@\S*' contained containedin=cComment
syn match cAttribute '\[\[\w\+\]\]'
syn keyword cOffsetof offsetof

hi link cOffsetof Operator
hi link cOps Operator
hi link cParens Delimiter
hi link cMemberAccess Delimiter
hi link cCommentTag SpecialComment
hi link cAttribute Special
