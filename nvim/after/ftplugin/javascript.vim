setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = ''
endif

let b:undo_ftplugin .= '| setlocal '.join([
      \ 'expandtab<',
      \ 'tabstop<',
      \ 'softtabstop<',
      \ 'shiftwidth<',
      \])
