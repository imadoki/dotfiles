" ウィンドウサイズ
set columns=180
set lines=50

" タブを表示する
set showtabline=2

" コマンドライン行数
set cmdheight=1

" 一時ファイルを作成しない
set nobackup
set noundofile

" カラースキーム
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
set background=dark

" ビープ音を消す
set visualbell t_vb=

" .gvimrc
set transparency=10

if has('mac')
	set guifont=Ricty:h16
endif
