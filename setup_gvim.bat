@echo off

rem HOME�f�B���N�g���ɍ쐬����
set HOME="C:\Users\Onwer"
rem Github���玝���Ă���dotfiles�̃f�B���N�g�����w��
set dotfiles="C:\Users\Onwer\dotfiles"

rem �V���{���b�N�����N
mklink /d %HOME%\.vim %dotfiles%\.vim
mklink %HOME%\.gvimrc %dotfiles%\.gvimrc
mklink %HOME%\.vimrc %dotfiles%\.vimrc