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

" snippet plugins
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

" quickrun
NeoBundle 'thinca/vim-quickrun'

" comentout
NeoBundle 'tyru/caw.vim'
" memolist
" NeoBundle 'glidenote/memolist.vim'

" install colorscheme
NeoBundle 'tomasr/molokai'
" install solarized
NeoBundle 'altercation/vim-colors-solarized'

" markdown plugins
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" ctags
NeoBundle 'majutsushi/tagbar'
NeoBundle 'szw/vim-tags'
NeoBundleLazy 'soramugi/auto-ctags.vim', {
		\ "autoload": {
		\ "filetypes": ["cpp", "py"]
		\}}

"c++ plugins
NeoBundleLazy 'vim-jp/cpp-vim', {
	\ "autoload": {
	\	'filetypes': ['cc', 'cpp']
	\}}

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

" processing syntax
NeoBundleLazy 'sophacles/vim-processing', {
		\  "autoload": {
		\    "filename_patterns": '.*\.pde'
		\  }}

" quickfix
NeoBundle "osyo-manga/unite-quickfix"

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
"" keybind
" tabで下へ
inoremap <expr><TAB> pumvisible() ? "\<Down>": "\<TAB>"
" shift+tabで上へ
inoremap <expr><S-TAB> pumvisible() ? "\<Up>": "\<S-TAB>"

"---------------------------------------------------
"" neosnippet設定
"---------------------------------------------------
let g:neosnippet#snippets_directory='~/dotfiles/.vim/bundle/vim-snippets/snippets, ~/dotfiles/.vim/snippets'
"" keybind
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": pumvisible() ? "\<C-n>": "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>"


"---------------------------------------------------
"" cap.vim 設定
"---------------------------------------------------
" '\c' is comentout and coment
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

"---------------------------------------------
"" quickrunの設定
"---------------------------------------------
" QuickRunの設定オブジェクトを作成する
let g:quickrun_config = {}
let g:quickrun_config._ = {
			\'runner': 'vimproc',
			\  'runner/vimproc/updatetime': 100
			\}

" tex compile
let g:quickrun_config.tex = {
			\  'command': 'latexmk',
			\  'outputter': 'error',
			\  'outputter/error/error': 'quickfix',
			\  'cmdopt': '-gg -pdfdvi',
			\  'exec': ['%c %o %s']
			\}
augroup myLaTexQuickrun
	au!
	au BufEnter *.tex nnoremap <Leader>v :call <SID>TexPdfView() <CR>
augroup END
function! s:TexPdfView()
	let texPdfFilename = expand('%:r') . '.pdf'
	if exists("g:quickrun_config['tex']['srcfile']")
		let texPdfFilename = fnamemodify(g:quickrun_config['tex']['srcfile'], ':.:r') . '.pdf'
	endif
	if has('unix')
		let g:TexPdfViewCommand = '!'. 'zathura '. texPdfFilename
	endif
	execute g:TexPdfViewCommand
endfunction

" run processing
augroup Processing
    autocmd!
    autocmd BufNewFile *.pde :setl filetype=processing
    autocmd BufReadPost *.pde :setl filetype=processing
augroup END

let g:quickrun_config.processing = {
			\  'command': 'processing-java',
			\  'exec': '%c --sketch=%s:p:h/ --output=%s:p:h/tmp/ --run --force'
			\}


"---------------------------------------------
"" VimFilerの設定
"---------------------------------------------
" デフォルトのファイラにvimfilerを使う
let g:vimfiler_as_default_explorer = 1
" キーマップ設定
nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
" カレントディレクトリでファイラを開く
nnoremap <silent> [vimfiler]c :VimFilerCurrentDir -tab<CR>



filetype plugin indent on     " required!
filetype indent on

"--------------------------------------------------
"" 文字コードの自動認識
"--------------------------------------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"---------------------------------------------
"" カラースキーマの設定
"---------------------------------------------
" set colorscheme
colorscheme molokai
let g:molokai_original=1
set background=dark
" colorscheme solarized
set t_Co=256

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
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"---------------------------------------------
"" ファイル・タイプ別の設定
"---------------------------------------------
" setting python django css
autocmd FileType css,javascript setl autoindent
autocmd FileTYpe css,javascript setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType htmldjango setl autoindent
autocmd FileType htmldjango setl shiftwidth=2 tabstop=2 softtabstop=2

" setting c++
autocmd Filetype cpp setl autoindent
autocmd FileType cpp setl expandtab tabstop=2 shiftwidth=2 softtabstop=2
" F5でmake
noremap <F5> :<C-u>make<CR>

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

"-------------------------------------------------------------
"" その他の設定
"-------------------------------------------------------------
" F9でvimrcを開く
nnoremap <F9> :tabedit ~/.vimrc<CR>
" F10でvimrc, gvimrcを読み込む
nnoremap <F10> :source ~/.vimrc \| :source ~/.gvimrc<CR>
" C-Lでハイライトを消す 
nnoremap <C-L> :nohl<CR><C-L>

syntax on
