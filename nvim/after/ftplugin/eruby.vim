set noexpandtab
set tabstop=4
set shiftwidth=4

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin= ''
endif

let b:undo_ftplugin .= '| setlocal '.join([
      \'expandtab',
      \'tabstop<',
      \'shiftwidth<',
      \])
