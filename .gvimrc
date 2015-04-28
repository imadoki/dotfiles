" ウィンドウサイズ
set columns=180
set lines=50

" タブを表示する
set showtabline=2

" コマンドライン行数
set cmdheight=1

" バックアップファイルの設定
set backup
set backupdir=~/vim_tmp/bak
set swapfile
set directory=~/vim_tmp/swp
set noundofile

" カラースキーム
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
set background=dark

" ビープ音を消す
set visualbell t_vb=

if has('mac')
	set guifont=Ricty\ Regular\ for\ Powerline:h16
    set transparency=10
endif
