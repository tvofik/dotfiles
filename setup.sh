#!/usr/bin/env bash

# if [ "$#" -ne 1 ]; then
#     echo "Usage: install.sh <home_directory>"
#     exit 1
# fi

# homedir=$1

# echo "Setting up a machine? Nice!"

# echo ${homedir}

if ! [[ command -v brew > /dev/null 2>&1 ]]; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Brew to PATH for arm64 Architecture "M1 Mac" &  Install Rosetta
  if [[ arch = "arm64" ]]; then 
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/tvofik/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    sudo softwareupdate --install-rosetta --agree-to-license
    # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/tvofik/.zprofile
    # eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew is already installed... skipping the installation"
  echo "Updating Homebrew..."
  brew update
fi

# Clone Repo
echo "Cloning Repo..."
git clone https://github.com/tvofik/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# /bin/bash install.sh ${homedir}
echo "$HOME is the HOME directory"
/bin/bash install.sh $HOME