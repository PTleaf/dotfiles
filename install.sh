#!/bin/zsh

set -e

echo "Install Homebrew"
if [ ! -x "$(command -v brew)" ]
then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
fi


echo "Install with Brew Bundle"
set +e
export PATH=$PATH:/opt/homebrew/bin
brew bundle --file="./brewfile"
set -e
