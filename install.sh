#!/bin/zsh

set -e

echo "Install Homebrew"
if [ ! -x "$(command -v brew)" ]
then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


echo "Install with Brew Bundle"
set +e
export PATH=$PATH:/opt/homebrew/bin
brew bundle
set -e
