#!/usr/bin/env bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ${homedir}/dotfiles
# And also installs Homebrew Packages & Pip Packages
############################

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

homedir=$1

# dotfiles directory
dotfiledir=~/.dotfiles

# list of files/folders to symlink in ${homedir}
files="zshrc aliases tmux.conf"

# change to the dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd ${dotfiledir}
echo "...done"

# Run the Homebrew Script
. ./brew.sh

#! Add brew bundle install instead of brew.sh
# brew bundle --file=~/.dotfiles/Brewfile

# Run the pip script
. ./pip.sh

# Install OH-MY-ZSH
echo "Installing OH-MY-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# create symlinks (will overwrite old dotfiles)
for file in ${files}; do
    echo "Creating symlink to $file in home directory."
    ln -sf ${dotfiledir}/.${file} ~/.${file}
done

# replace the .gitconfig in home directory  
cp ${dotfiledir}/.gitconfig ~/.gitconfig

# ITERM Preference setup
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Speed up the Dock animation time
defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock


# echo "Configuring OS..."
# # Set fast key repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 0
# # Require password as soon as screensaver or sleep mode starts
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0
# # Show filename extensions by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# # Enable tap-to-click
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
