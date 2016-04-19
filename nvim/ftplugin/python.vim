if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin=1

setlocal autoindent
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal expandtab
setlocal smarttab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=80
