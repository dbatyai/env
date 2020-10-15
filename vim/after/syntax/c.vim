hi Comment cterm=bold ctermfg=Blue
hi Statement ctermfg=Yellow
hi Constant ctermfg=Gray
hi Number cterm=bold ctermfg=Gray
hi Search ctermfg=White
hi String cterm=bold ctermfg=Yellow
hi Preproc cterm=bold ctermfg=Cyan
hi Invoc cterm=bold ctermfg=Red
syn match Invoc display "\<[A-Z][0-9A-Z_]*\>"
hi Operator ctermfg=DarkGreen
syn match PreProcCondition "^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\|else\|endif\)\>"
hi link PreProcCondition Preproc
syn match PreProcDefine "^\s*\(%:\|#\)\s*\(define\)\>"
hi link PreProcDefine Preproc
hi Special ctermfg=Magenta
hi YcmErrorSection ctermbg=DarkRed ctermfg=White
