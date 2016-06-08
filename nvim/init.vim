"python3 support
let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'

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

" neosnippet settings {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" }}}

" indent guides settings {{{
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd myvimrc VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#262626 ctermbg=gray
autocmd myvimrc VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3c3c3c ctermbg=darkgray
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
" }}}

syntax on
colorscheme molokai
let g:molokai_original=1
set background=dark
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

autocmd myvimrc FileType markdown nnoremap <silent> <Leader>v :PrevimOpen <CR>
autocmd myvimrc FileType htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2

" F9でvimrcを開き，F10でvimrcを読み込む
nnoremap <F9> :tabedit $MYVIMRC<CR>
nnoremap <F10> :source $MYVIMRC<CR>

" C-Lでハイライトを消す 
nnoremap <C-L> :nohl<CR><C-L>

" caw.vim settings {{{
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
" }}}

" unite setting {{{
  nnoremap [unite] <Nop>
  nmap <Leader>u [unite]
  nnoremap <silent> [unite]b :Unite buffer<CR>
  function! s:unite_smart_grep()
    if unite#sources#grep_git#is_available()
      Unite grep/git:. -buffer-name=search-buffer
    elseif unite#sources#grep_hg#is_available()
      Unite grep/hg:. -buffer-name=search-buffer
    else
      Unite grep:. -buffer-name=search-buffer
    endif
  endfunction
  nnoremap <silent> [unite]gg :<C-u>call <SID>unite_smart_grep()<CR>
" }}}

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
if has('mac')
  set clipboard+=unnamed
endif
" バックアップファイルの設定
set backup
set backupdir=~/.config/nvim/tmp/bak
set swapfile
set directory=~/.config/nvim/tmp/swp
set noundofile

filetype plugin indent on
