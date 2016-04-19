#! /bin/bash
# make XDG_CONFIG
if [ ! -e $XDG_CONFIG_HOME ]; then
  mkdir $XDG_CONFIG_HOME
  echo "make ${XDG_CONFIG_HOME}"
fi

# make symbolic link
ln -s ~/dotfiles/nvim/ $XDG_CONFIG_HOME/nvim
mkdir -p "${XDG_CONFIG_DIR}nvim/tmp/swp"
mkdir -p "${XDG_CONFIG_DIR}nvim/tmp/bak"
