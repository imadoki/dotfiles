" vimscript用の設定 Shougoさんのものを丸パクリ

" おまじない
" 'compatible'オプションによる不具合を回避するため，cpoをs:save_に待避し，
" cpoをvimデフォルトに切り替える
let s:save_cpo = &cpo
set cpo&vim

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'setlocal modeline<'

setlocal shiftwidth=2 softtabstop=2
setlocal iskeyword+=:,#

" goto file (gf) 設定
let &l:path = join(map(split(&runtimepath, ','), 'v:val."/autoload"'), ',')
setlocal suffixesadd=.vim
setlocal includeexpr=fnamemodify(substitute(v:fname,'#','/','g'),':h')

" cpoを元に戻す
let &cpo = s:save_cpo
unlet s:save_cpo
