#!/usr/bin/env bash

# Settings and configurations
# DOCK CONFIG
# Change the Dock size
defaults write com.apple.dock tilesize -int 24 # Note: default value is value is 64
# Make the Dock autohide 
defaults write com.apple.dock autohide -int 1
# Speed up the Dock animation
defaults write com.apple.dock autohide-time-delay -float 0.0001
# defaults write com.apple.dock autohide-time-modifier -float 0.25
killall Dock #Restart the Dock

# ITERM Preference setup
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

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




# Settings to look for?
#when performing a search = "Search the current folder"
#new Finder windoews shows = "tabs"
General 
# apperance = 'Dark"
# accent color = "graphite"
# Highlight color = "graphite"
# sidebar icon size = "small"
# show scroll bars = 'automatically based on moiuse or trackpad'
# click in the scroll bar = 'to jump to the next page'
# default web browser = "brave browser"
# prefer tabs "in full screen"
# allow Handoff bewteen this mac and your iCloud devices 
# track pad settings
# applications on the dock 