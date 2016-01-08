set nocompatible               " be iMproved
filetype off


" MacVim用にpythonのライブラリ指定
if has('gui_macvim')
  let $PYTHON_DLL="/Users/owner/.pyenv/versions/2.7.9/lib/libpython2.7.dylib"
  " let $PYTHON3_DLL="/Users/owner/.pyenv/versions/3.4.3/lib/libpython3.4m.dylib"
endif

" PATHの自動更新関数
" | 指定された path が $PATH に存在せず、ディレクトリとして存在している場合
" | のみ $PATH に加える
function! IncludePath(path)
  " define delimiter depends on platform
  if has('win16') || has('win32') || has('win64')
    let delimiter = ";"
  else
    let delimiter = ":"
  endif
  let pathlist = split($PATH, delimiter)
  if isdirectory(a:path) && index(pathlist, a:path) == -1
    let $PATH=a:path.delimiter.$PATH
  endif
endfunction

" pyenvでインストールしたpythonをパスに加える
call IncludePath(expand("~/.pyenv/shims"))

"-------------------------------------------------
"" neobundleを設定
"-------------------------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/dotfiles/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/dotfiles/.vim/bundle/'))

" manage vim plugin
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', { 'build': {
	\	  'cygwin': 'make -f make_cygwin.mak',
 	\	  'mac': 'make -f make_mac.mak',
 	\	  'unix': 'make -f make_unix.mak',
 	\	 },
 	\}

NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neossh.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
NeoBundle 'kana/vim-smartinput'

" snippet plugins
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'

" quickrun
NeoBundle 'thinca/vim-quickrun'

" webapi
NeoBundle 'mattn/webapi-vim'

" comentout
NeoBundle 'tyru/caw.vim'
" memolist
" NeoBundle 'glidenote/memolist.vim'

" install colorscheme
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'

" syntax checker
" istall syntastic
NeoBundle "scrooloose/syntastic"

" markdown plugins
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle "godlygeek/tabular"
NeoBundle "joker1007/vim-markdown-quote-syntax"
NeoBundle "rcmdnk/vim-markdown"

" ctags
NeoBundle 'majutsushi/tagbar'
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
            \ "depends": ["Shougo/vimproc"],
            \ 'autoload': {
            \   'commands': [
            \     { 'name': 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
            \     { 'name': 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
            \     'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
            \ ],
            \}}

"c++ plugins
NeoBundleLazy 'vim-jp/cpp-vim', {
	\ "autoload": {
 	\	'filetypes': ['cc', 'cpp']
 	\}}

" python settings
" DJANGO_SETTINGS_MODULE を自動設定
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

" python補完用. vim-pyenvのために常にロード
NeoBundle "davidhalter/jedi-vim"
" pyenv処理用.
NeoBundle "lambdalisue/vim-pyenv", {"depends": ['davidhalter/jedi-vim']}

" processing syntax
NeoBundleLazy 'sophacles/vim-processing', {
		\  "autoload": {
		\    "filename_patterns": '.*\.pde'
		\  }}

" quickfix
NeoBundle "osyo-manga/unite-quickfix"

" evervim
NeoBundle 'kakkyz81/evervim'

call neobundle#end()

map \ <Leader>

"-------------------------------------------------
"" neocomplete設定
"-------------------------------------------------
""辞書ファイル
autocmd BufRead *.php\|*.ctp\|*.tpl :set dictionary=~/.vim/dictionaries/php.dict filetype=php
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#manual_completion_start_length = 0
" pythonのオムニ補完でクラッシュするため,無効化
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.python = ''
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
            \'runner/vimproc/updatetime': 60,
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
	au BufEnter *.tex nnoremap <silent> <Leader>v :call <SID>TexPdfView() <CR>
augroup END
function! s:TexPdfView()
	let texPdfFilename = expand('%:r') . '.pdf'
	if exists("g:quickrun_config['tex']['srcfile']")
		let texPdfFilename = fnamemodify(g:quickrun_config['tex']['srcfile'], ':.:r') . '.pdf'
	endif
    if has('unix')
        let g:TexPdfViewCommand = 'zathura '.shellescape(texPdfFilename).'&'
        echomsg g:TexPdfViewCommand
        " run zathura background
        call system(g:TexPdfViewCommand)
    endif
    if has('win64')
        let l:targetPdfFilePath = expand('%:p:r'). '.pdf'
        let l:sumatraPDF = '"C:\Program Files (x86)\SumatraPDF\SumatraPDF.exe" '
        let g:TexPdfViewCommand = l:sumatraPDF. l:targetPdfFilePath
        execute '!start ' g:TexPdfViewCommand
	endif
	" execute g:TexPdfViewCommand
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

" run pandoc
if executable('pandoc')
    let s:pandoc_css_path = expand('~/dotfiles/pandoc/css/github.css')
    let g:quickrun_config.markdown = {
                \ 'command': 'pandoc',
                \ 'srcfile': expand('%'),
                \ 'hook/time': '1',
                \ 'outputter': 'browser',
                \ 'outputter/browser/name': expand('%:p:r') . '.html',
                \ 'outputter/error/success': 'buffer',
                \ 'outputter/error/error': 'buffer',
                \ 'cmdopt': '-s --self-contained -c "' . s:pandoc_css_path . '" -t html5 -f markdown_github+hard_line_breaks',
                \ 'exec': [
                \   '%c %s %o -o %S:t:r.html',
                \ ],
                \ }
endif

" python
let g:quickrun_config.python = {
            \ 'command': 'python',
            \ 'exec': '%c %s',
            \'outputter': 'error',
            \'outputter/error/success': 'buffer',
            \'outputter/error/error': 'quickfix',
            \'outputter/buffer/split': ':rightbelow 8sp',
            \'outputter/buffer/close_on_empty': 1,
            \}

"---------------------------------------------
"" syntasticの設定
"---------------------------------------------
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': ['python'],
    \ 'passive_filetypes': ['tex']
    \}
let g:syntastic_python_checkers = ["flake8"]
"
" C++
let g:syntastic_cpp_compiler_options = "-std=c++11 -stdlib=libc++"

"---------------------------------------------
"" VimFiler
"---------------------------------------------
" デフォルトのファイラにvimfilerを使う
let g:vimfiler_as_default_explorer = 1
" 編集ファイルをタブで開く
let g:vimfiler_edit_action='tabopen'
" カレントディレクトリを編集ファイルのディレクトリまで移動する
let g:vimfiler_enable_auto_cd = 1
" prefix設定
nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
" その場でファイラを開く
nnoremap <silent> [vimfiler]f :VimFiler -quit<CR>
" tabでファイラを開く
nnoremap <silent> [vimfiler]t :VimFiler -tab -quit<CR>
" 分割でファイラを開く
nnoremap <silent> [vimfiler]s :VimFiler -split -no-quit<CR>

"---------------------------------------------
"" VimShell
"---------------------------------------------
" prompt
" let g:vimshell_prompt_expr = 'getcwd()." >"'
" let g:vimshell_prompt_pattern = '^\f\+ >'
if has('mac')
let g:vimshell_prompt_expr =
		\ 'escape(iconv(fnamemodify(getcwd(), ":~").">", "utf-8-mac", "char"), "\\[]()?! ")." "'
else
let g:vimshell_prompt_expr =
		\ 'escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
endif
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '

" prefix設定
nnoremap [vimshell] <Nop>
nmap <Leader>s [vimshell]
nnoremap <silent> [vimshell]t :VimShellTab<CR>
"文字コード設定
let g:vimshell_interactive_encodings = {
            \'/': 'utf-8-mac',
            \}

"---------------------------------------------
"" jedi-vim
"---------------------------------------------
" 補完時、最初の項目を選択しないようにする
let g:jedi#popup_select_first = 0
" quickrunとキーバインドが被るためリネームキーバインドを大文字に変更
let g:jedi#rename_command = '<Leader>R'


"---------------------------------------------
"" EverVim
"---------------------------------------------
" 接続に使用するトークンを指定
let g:evervim_devtoken="S=s311:U=293e861:E=156ebb5b8dd:C=14f94048b90:P=1cd:A=en-devtoken:V=2:H=7533ed5a4a95cbfc1e375d9b13a785e9"
" マッピング
nnoremap [evervim] <Nop>
nmap <Leader>e [evervim]
nnoremap <silent> [evervim]l :EvervimNotebookList<CR>
nnoremap <silent> [evervim]c :EvervimCreateNote<CR>

"---------------------------------------------

filetype plugin indent on     " required!
filetype indent on

NeoBundleCheck

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

" powerline by pip
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set showtabline=2
set noshowmode

"---------------------------------------------
"" 基本設定
"---------------------------------------------
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
" *レジスタにもヤングする
set clipboard+=unnamed
" バックアップファイルの設定
set backup
set backupdir=~/.vim/tmp/bak
set swapfile
set directory=~/.vim/tmp/swp
set noundofile

"---------------------------------------------
"" ファイル・タイプ別の設定
"---------------------------------------------
" setting text
" デフォルトvimrc_exampleのtextwidth設定を上書き
autocmd FileType text setlocal textwidth=0

" setting python django css
autocmd FileType css,javascript setl autoindent
autocmd FileTYpe css,javascript setl tabstop=2 expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType htmldjango setl autoindent
autocmd FileType htmldjango setl shiftwidth=2 tabstop=2 softtabstop=2

" setting c++
autocmd FileType cpp setl autoindent
autocmd FileType cpp setl expandtab tabstop=2 shiftwidth=2 softtabstop=2
" F5でmake
noremap <F5> :<C-u>make<CR>

" markdown setting
let g:vim_markdown_liquid=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_math=1
autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup markdownView
	au!
	au FileType markdown nnoremap <silent> <Leader>v :PrevimOpen <CR>
augroup END

nnoremap <C-]> g<C-]> 
nmap <Leader>t :TagbarToggle<CR>

" alpaca_tags
let s:bundle = neobundle#get("alpaca_tags")
function! s:bundle.hooks.on_source(bundle)
    let g:alpaca_tags#config = {
                \   "_": "-R --sort=yes --languages=+Python,Vim,C,C++,Lua",
                \}
endfunction
unlet s:bundle
augroup AlpacaTags
    autocmd!
    if exists(":AlpacaTags")
        autocmd BufEnter * AlpacaTagsSet
        autocmd BufWritePost * AlpacaTagsUpdate
    endif
augroup END

"-------------------------------------------------------------
"" その他の設定
"-------------------------------------------------------------
" F8でgvimrcを開く
nnoremap <F8> :tabedit ~/.gvimrc<CR>
" F9でvimrcを開く
nnoremap <F9> :tabedit ~/.vimrc<CR>
" F10でvimrc, gvimrcを読み込む
nnoremap <F10> :source ~/.vimrc \| :source ~/.gvimrc<CR>
" C-Lでハイライトを消す 
nnoremap <C-L> :nohl<CR><C-L>

syntax on
