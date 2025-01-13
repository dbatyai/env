syn match pythonStringFormat '%s' containedin=pythonString
syn match pythonStringFormat '[{}]' containedin=pythonString
syn match pythonParens '[(){}[\].:]'
syn match pythonOps '[+\-*%!=|&^<>]'
syn keyword pythonSelf self
syn keyword pythonCls cls
syn keyword pythonBoolean False
syn keyword pythonBoolean True

hi link pythonStringFormat Special
hi link pythonParens Delimiter
hi link pythonOps Operator
hi link pythonDiv Operator
hi link pythonBoolean Boolean
hi link pythonSelf Special
hi link pythonCls Special

hi pythonFunction cterm=bold ctermfg=DarkCyan
hi pythonString cterm=bold ctermfg=DarkGreen
