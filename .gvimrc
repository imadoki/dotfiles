" ウィンドウサイズ
set columns=180
set lines=50

" タブを表示する
set showtabline=2

" コマンドライン行数
set cmdheight=1

" カラースキーム
colorscheme molokai
let g:molokai_original=1
let g:rehash256=1
set background=dark

" ビープ音を消す
set visualbell t_vb=

if has('mac')
	set guifont=Ricty_Regular_for_Powerline:h16
  set transparency=10
endif
if has('win64')
	set guifont=Inconsolata_for_Powerline:h12:cSHIFTJIS,MeiryoKe_Console:h12:cSHIFTJIS
endif
