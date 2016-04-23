scriptencoding utf-8

"python3 support
let g:python3_host_prog = expand('$PYENV_ROOT') . '/shims/python3'

if &compatible
  set nocompatible               " Be iMproved
endif

" reset augroup
augroup myvimrc
  autocmd!
augroup END

" dein settings {{{
" deinが導入されていない場合自動で導入する
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" Check cache
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" deoplete settings {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}

"" vim-monster setting (ruby)
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:deoplete#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}

syntax on
colorscheme molokai
let g:molokai_original=1
set background=dark
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

autocmd myvimrc FileType markdown nnoremap <silent> <Leader>v :PrevimOpen <CR>

" F9でvimrcを開き，F10でvimrcを読み込む
nnoremap <F9> :tabedit $MYVIMRC<CR>
nnoremap <F10> :source $MYVIMRC<CR>

" C-Lでハイライトを消す 
nnoremap <C-L> :nohl<CR><C-L>

set backspace=indent,eol,start
set history=50
set ignorecase
set smartcase
set hlsearch
set incsearch
set number
set showmatch
set wrap
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" *レジスタにもヤンクする
set clipboard+=unnamed
" バックアップファイルの設定
set backup
set backupdir=~/.config/nvim/tmp/bak
set swapfile
set directory=~/.config/nvim/tmp/swp
set noundofile

filetype plugin indent on
