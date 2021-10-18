let s:base0 = [ '#242424', 235 ]
let s:base1 = [ '#353535', 238 ]
let s:base2 = [ '#444444', 241 ]
let s:base3 = [ '#585858', 245 ]
let s:base4 = [ '#666666', 248 ]
let s:base5 = [ '#808080', 251 ]
let s:base6 = [ '#969696', 255 ]


let s:none =    [ '#000000', 'None' ]
let s:black =   [ '#000000', 0 ]
let s:white =   [ '#ffffff', 15 ]
let s:grey =    [ '#8a8a8a', 245 ]
let s:yellow =  [ '#cae682', 178 ]
let s:orange =  [ '#e5786d', 214 ]
let s:red =     [ '#e5786d', 203 ]
let s:magenta = [ '#f2c68a', 127 ]
let s:blue =    [ '#8ac6f2', 75 ]
let s:cyan =    [ '#5fd7d7', 80]
let s:green =   [ '#95e454', 76 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left =  [ [ s:black, s:green ], [ s:red, s:none ], [ s:white, s:none ] ]
let s:p.insert.left =  [ [ s:black, s:blue ], [ s:red, s:black ], [ s:white, s:black ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:red, s:black ], [ s:white, s:black ] ]
let s:p.visual.left =  [ [ s:black, s:orange ], [ s:red, s:black ], [ s:white, s:black ] ]

let s:p.normal.middle =  [ [ s:white, s:none ] ]
let s:p.normal.right =   [ [ s:base4, s:base1 ], [ s:base0, s:base4 ] ]
let s:p.normal.error =   [ [ s:black, s:red ] ]
let s:p.normal.warning = [ [ s:black, s:yellow ] ]

let s:p.inactive.left =   [ [ s:grey, s:black ] ]
let s:p.inactive.middle = [ [ s:grey, s:black ] ]
let s:p.inactive.right =  [ [ s:base0, s:base1 ], [ s:base0, s:base2 ] ]

let g:lightline#colorscheme#lightlinecolors#palette = lightline#colorscheme#flatten(s:p)
