set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/dotfiles/.vim/bundle/'))
endif

" manage vim plugin
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
	\	  'cygwin': 'make -f make_cygwin.mak',
	\	  'mac': 'make -f make_mac.mak',
	\	  'unix': 'make -f make_unix.mak',
	\	 },
	\}

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/vimfiler'
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

" latex settings
NeoBundleLazy 'git://git.code.sf.net/p/vim-latex/vim-latex', {
	\ "autoload": {
	\   "filetypes": ["tex"]
	\ }
	\}

" python settings
NeoBundleLazy 'git://github.com/kevinw/pyflakes-vim.git', {
	\ "autoload": {
	\   "filetypes": ["python", "python3"]
	\ }
	\}
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
NeoBundleLazy "jmcantrell/vim-virtualenv", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

call neobundle#end()


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

" caw.vim
" '\c' is comentout and coment
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

filetype plugin indent on     " required!
filetype indent on

" set colorscheme
 colorscheme molokai
" set background=dark
" colorscheme solarized
set t_Co=256

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
nmap <Leader>t :TagbarToggle<CR>

" auto-ctags.vim
let s:bundle = neobundle#get("auto-ctags.vim")
function! s:bundle.hooks.on_source(bundle)
	let g:auto_ctags = 1	" ファイル保存時にtagsを更新
endfunction
unlet s:bundle

" vimfiler
" 現在開いているバッファをIDE風に開く
nnoremap <silent> <Leader>fe :<C-u>VimFilerBufferDir -splite -simple -winwidth=35 -no-quit<CR>

" 
nnoremap <C-L> :nohl<CR><C-L>

syntax on

" backスペースでtabなどを削除できるようにする
set backspace=indent,eol,start
set history=50
set ignorecase
set smartcase
set hlsearch
set incsearch
set number
set showmatch
set wrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
