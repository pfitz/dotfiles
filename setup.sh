#!/bin/bash

# ack
ln -sf `pwd`/ack/ackrc ~/.ackrc

#nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
ln -sf `pwd`/nvim/init.vim ~/.config/nvim/

nvim +PlugInstall

echo "# Now for some manual stuff, sorry!"
echo "## nvim"
echo "To install the nvim plugins, open up vim and type ':PlugInstall'\n"

ln -sf `pwd`/tmux/.tmux.conf ~/.tmux.conf
