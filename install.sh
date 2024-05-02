#!/bin/zsh
# tmux
if [ ! type tmux > /dev/null 2>&1 ]
then
    brew install tmux
fi

if [ ! -d ~/.tmux/plugins/tpm ]
then
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
fi

if test ! -f ~/.config/.tmux.conf
then
    ln -s ~/dotfiles/.tmux.conf ~/.config/.tmux.conf
fi

# nvim
if [ ! type nvim > /dev/null 2>&1 ]
then
    brew install nvim
fi

# layygit
if [ ! type lazygit > /dev/null 2>&1 ]
then
    brew install lazygit
fi

# nvm
if [ ! type nvm > /dev/null 2>&1 ]
then
    brew install nvm
    nvm install v18
    nvm alias default v18
    nvm use v18
fi

