#!/usr/bin/env bash

# VARIABLES #

# dotfiles directory
dotfiledir=~/.dotfiles

# list of files/folders to symlink in ${homedir}
files="zshrc aliases tmux.conf"

if ! command -v brew > /dev/null 2>&1; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Brew to PATH for arm64 Architecture "M1 Mac" &  Install Rosetta
  if [[ arch = "arm64" ]]; then 
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    sudo softwareupdate --install-rosetta --agree-to-license
    # eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "Homebrew is already installed... skipping the installation"
  echo "Updating Homebrew..."
  brew update
fi

# Install OH-MY-ZSH
echo "Installing OH-MY-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone Repo
echo "Cloning Repo..."
git clone https://github.com/tvofik/dotfiles.git ${dotfiledir}

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
# . ./brew.sh
#! Add brew bundle install instead of brew.sh
brew bundle --file=${dotfiledir}/Brewfile

# Run the pip script
. ./pip.sh

# Run the System Configuration script
# . ./sysconfig.sh