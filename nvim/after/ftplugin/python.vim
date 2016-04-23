setlocal autoindent
setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '| setlocal '.join([
      \ 'autoindent<',
      \ 'smartindent<',
      \ 'cinwords<',
      \ 'expandtab<',
      \ 'tabstop<',
      \ 'shiftwidth<',
      \ 'softtabstop<',
      \ 'textwidth<',
      \])
