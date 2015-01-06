@echo off

rem HOMEディレクトリに作成する
set HOME="C:\Users\Onwer"
rem Githubから持ってきたdotfilesのディレクトリを指定
set dotfiles="C:\Users\Onwer\dotfiles"

rem シンボリックリンク
mklink /d %HOME%\.vim %dotfiles%\.vim
mklink %HOME%\.gvimrc %dotfiles%\.gvimrc
mklink %HOME%\.vimrc %dotfiles%\.vimrc