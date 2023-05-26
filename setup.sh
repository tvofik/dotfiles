#!/usr/bin/env bash

# VARIABLES #

# Colors
Color_Off='\033[0m'       # Text Reset
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan

echo -e "${BPurple}*** Starting Script ***${Color_off}"

# dotfiles directory
dotfiledir=~/.dotfiles

# list of files/folders to symlink in ${homedir}
# files="zshrc aliases tmux.conf"
declare -a files=("zshrc" "aliases" "tmux.conf")

if ! command -v brew > /dev/null 2>&1; then
  echo -e "${BPurple}***** Installing homebrew *****${Color_off}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Brew to PATH for arm64 Architecture "M series Macs" &  Install Rosetta
  if [[ `arch` == "arm64" ]]; then 
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    sudo softwareupdate --install-rosetta --agree-to-license
    # eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo -e "${BPurple}***** Homebrew is already installed, skipping the installation *****${Color_off}"
  echo -e "${BPurple}***** Updating Homebrew *****${Color_off}"
  brew update
fi

# Install OH-MY-ZSH
echo -e "${BPurple}***** Installing OH-MY-ZSH *****${Color_off}"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Download zsh-autosuggestion
echo -e "${BPurple}***** Cloning ZSH Autosuggestions *****${Color_off}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Clone Repo
echo -e "${BPurple}***** Cloning Repo *****${Color_off}"
git clone https://github.com/tvofik/dotfiles.git ${dotfiledir}

# create symlinks (will overwrite old dotfiles)
for file in ${files[@]}; do 
    echo -e "${BPurple}***** Creating symlink to $file in home directory *****${Color_off}"
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

# Add brew bundle install instead of brew.sh
echo -e "${BPurple}***** Installing applications using brew *****${Color_off}"
brew bundle --file=${dotfiledir}/Brewfile

# Run the pip script
echo -e "${BPurple}***** Installing python packages using pip *****${Color_off}"
. ${dotfiledir}/pip.sh

# Run the System Configuration script
echo -e "${BPurple}***** Applying system configuration *****${Color_off}"
. ${dotfiledir}/sysconfig.sh
