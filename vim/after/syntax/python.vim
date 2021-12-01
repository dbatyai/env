syn match pythonStringFormat '%s' containedin=pythonString
syn match pythonParens '[(){}[\].:]'
syn match pythonOps '[+\-*%!=|&^]'
syn match cDiv '\s/\s'

hi link pythonStringFormat Special
hi link pythonParens Delimiter
hi link pythonOps Operator
hi link pythonDiv Operator

"hi pythonStatement cterm=bold ctermfg=LightBlue
hi pythonString cterm=bold ctermfg=DarkGreen
