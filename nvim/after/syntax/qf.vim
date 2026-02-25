syn match qfNoteLabel 'note:'
syn match qfErrorLabel 'error:'
syn match qfFileLoc '\S\+:\d\+:'
syn match qfFilePath '[a-zA-Z0-9_/]\+\.\w\+' contained containedin=qfFileLoc
syn match qfFileLine '\d\+' contained containedin=qfFileLoc
syn match qfErrorId '\[[a-zA-Z0-9_-]\+\]'
syn match qfIdent '\'[^']\+\''
syn match qfWarning 'warning' contained containedin=qfLineNr
syn match qfInfo 'info' contained containedin=qfLineNr
syn match qfFixAvailable '(fix available)'

hi link qfFilePath Directory
hi link qfFileLine LineNr
hi link qfErrorId NonText
hi link qfIdent String
hi link qfNoteLabel DiagnosticInfo
hi link qfErrorLabel DiagnosticError
hi link qfError DiagnosticError
hi link qfWarning DiagnosticWarn
hi link qfInfo DiagnosticInfo
hi link qfFixAvailable DiagnosticOK
