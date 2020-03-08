#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

homedir=$1

echo "Installing a new machine? Nice!"

echo ${homedir}

if ! command -v brew > /dev/null 2>&1; then
  echo "Installing homebrew..."
 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew is already installed... skipping the installation"
  echo "Updating Homebrew..."
  brew update    
fi

if ! command -v git > /dev/null 2>&1 ; then
  echo "Installing Git..."
  brew install git
else
  echo "Upgrading Git..."
  brew upgrade git
fi

# Clone Repo 
git clone https://github.com/tvofik/dotfiles.git ~/dotfiles
cd ~/dotfiles
. ./install.sh ${homedir}
