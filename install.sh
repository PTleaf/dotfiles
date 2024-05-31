#!/bin/zsh

set -e

system=""

if [[ "$OSTYPE" == "linux-gnu"* ]] then
    system=linux
elif [[ "$OSTYPE" == "darwin"* ]] then
    system=mac
else
    echo "无法确定当前系统环境"
    exit
fi

export http_proxy=http://sys-proxy-rd-relay.byted.org:8118 https_proxy=http://sys-proxy-rd-relay.byted.org:8118 no_proxy=.byted.org
export ALL_PROXY=socks5h://sys-proxy-rd-relay.byted.org:1080
export HOMEBREW_NO_AUTO_UPDATE=true

echo "Install Homebrew"
if [ ! -x "$(command -v brew)" ]
then
    echo "Installing homebrew..."
    NONINTERACTIVE=1 && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [[ $system == linux ]]
    then
        echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/:$PATH"' >>~/.zshrc
    elif [[ $system == mac ]]
    then
        echo 'export PATH="/opt/homebrew/bin:$PATH"' >>~/.zshrc
    fi
    source ~/.zshrc
fi


echo "Install with Brew Bundle"
set +e
brew bundle --file="./brewfile"
set -e

ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/.tmux.conf ~/.config/tmux.conf

