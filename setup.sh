#!/usr/bin/env bash

# if [ "$#" -ne 1 ]; then
#     echo "Usage: install.sh <home_directory>"
#     exit 1
# fi

# homedir=$1

# echo "Setting up a machine? Nice!"

# echo ${homedir}


# VARIABLES #
# dotfiles directory
dotfiledir=~/.dotfiles
# list of files/folders to symlink in ${homedir}
files="zshrc aliases tmux.conf"

# Clone Repo
echo "Cloning Repo..."
git clone https://github.com/tvofik/dotfiles.git ${dotfiledir}

cd ${dotfiledir}

# Install OH-MY-ZSH
echo "Installing OH-MY-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if ! [[ command -v brew > /dev/null 2>&1 ]]; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Brew to PATH for arm64 Architecture "M1 Mac" &  Install Rosetta
  if [[ arch = "arm64" ]]; then 
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

# create symlinks (will overwrite old dotfiles)
for file in ${files}; do
    echo "Creating symlink to $file in home directory."
    ln -sf ${dotfiledir}/.${file} ~/.${file}
done

# replace the .gitconfig in home directory  
cp ${dotfiledir}/.gitconfig ~/.gitconfig


# /bin/bash install.sh ${homedir}
# echo "$HOME is the HOME directory"
# /bin/bash install.sh $HOME #!Might not need anymore

# Install Application With Brew
# Run the Homebrew Script
. ./brew.sh
#! Add brew bundle install instead of brew.sh
# brew bundle --file=${dotfiledir}/Brewfile

# Run the pip script
. ./pip.sh