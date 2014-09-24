"プラグイン管理neobundle
set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'git://github.com/kevinw/pyflakes-vim.git'
NeoBundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
" vimfiler
NeoBundle 'Shougo/vimfiler'
" vimshell
NeoBundle 'Shougo/vimshell'
" comentout
NeoBundle 'tyru/caw.vim'
" memolist
NeoBundle 'glidenote/memolist.vim'

" install colorscheme
NeoBundle 'tomasr/molokai'
" install solarized
NeoBundle 'altercation/vim-colors-solarized'

" markdown plugins
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" ctag関連
NeoBundle 'majutsushi/tagbar'
NeoBundle 'szw/vim-tags'
NeoBundleLazy 'soramugi/auto-ctags.vim', {
		\ "autoload": {
		\ "filetypes": ["cc", "py"]
		\}}

" Djangoを正しくVimで読み込めるようにする
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
" Vimで正しくvirtualenvを処理できるようにする
NeoBundleLazy "jmcantrell/vim-virtualenv", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

nmap <Leader>t :TagbarToggle<CR>

"-------------------------------------------------
"" neocomplcache設定
"-------------------------------------------------
""辞書ファイル
autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dictionaries/php.dict filetype=php
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'

set rtp+=~/.vim/vundle.git/

" caw.vim
" '\c' is comentout and coment
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" backスペースでtabなどを削除できるようにする
set backspace=indent,eol,start

filetype plugin indent on     " required!
filetype indent on

" set colorscheme
 colorscheme molokai
" set background=dark
" colorscheme solarized
set t_Co=256

syntax on
set history=50
set ignorecase
set smartcase
set hlsearch
set incsearch
set number
set showmatch
set wrap
set tabstop=4

" setting python django css
autocmd FileType css,javascript setl autoindent
autocmd FileTYpe css,javascript setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType htmldjango setl autoindent
autocmd FileType htmldjango setl shiftwidth=2 tabstop=2 softtabstop=2

" setting c++
autocmd FileType cpp setl tabstop=4 shiftwidth=4 softtabstop=4

" markdown setting
autocmd BufRead,BufNewFile *.md set filetype=markdown

set tags+=tags
" 拡張子で読み込みタグを変更
" Python
au BufNewFile,BufRead *.py set tags+=$HOME/tags/Python.tags 

" vim-tags
au BufNewFile,BufRead *.py let g:vim_tags_project_tags_command = "ctags --languages=Python -f ~/tags/Python.tags `pwd` 2>/dev/null"
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 

let s:bundle = neobundle#get("auto-ctags.vim")
function! s:bundle.hooks.on_source(bundle)
	let g:auto_ctags = 1
endfunction
unlet s:bundle
" ファイル保存時にtagsファイルを作成する．
let g:auto_ctags = 1


" vimfiler
" 現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -splite -simple -winwidth=35 -no-quit<CR>

" 
nnoremap <C-L> :nohl<CR><C-L>
