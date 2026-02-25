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

hi pythonClass cterm=bold ctermfg=Cyan gui=bold guifg=#00CCCC
hi pythonFunction cterm=bold ctermfg=Cyan gui=bold guifg=#00CCCC
hi pythonString cterm=bold ctermfg=Green gui=bold guifg=#33DD33
