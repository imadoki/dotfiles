setlocal softtabstop=2
setlocal shiftwidth=2

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin= ''
endif

let b:undo_ftplugin .= '| setlocal '.join([
      \'shiftwidth<',
      \'softtabstop<',
      \])
