#!/usr/bin/env bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ${homedir}/dotfiles
# And also installs Homebrew Packages & Pip Packages
############################

if [ "$#" -ne 1 ]; then
    echo "Usage: install.sh <home_directory>"
    exit 1
fi

echo "Installing a new machine? Nice!"

if ! command -v brew > /dev/null 2>&1; then
  echo "Okay, lets do this. First things first, we need to install homebrew in order to get all the stuff you need"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew was already available... skipping the installation"
  echo "Let's update it instead! (you know you haven't updated in a while)"
  brew update
fi

homedir=$1

# dotfiles directory
dotfiledir=${homedir}/dotfiles

# list of files/folders to symlink in ${homedir}
files="bash_profile bash_prompt aliases gitconfig"

# change to the dotfiles directory
echo "Changing to the ${dotfiledir} directory"
cd ${dotfiledir}
echo "...done"

# create symlinks (will overwrite old dotfiles)
for file in ${files}; do
    echo "Creating symlink to $file in home directory."
    ln -sf ${dotfiledir}/.${file} ${homedir}/.${file}
done

# Download Git Auto-Completion
curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" > ${homedir}/.git-completion.bash
curl "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh" > ${homedir}/.git-prompt.sh

# Run the Homebrew Script
./brew.sh

# Download Docker Completion
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.25.3/contrib/completion/bash/docker-compose -o /usr/local/etc/bash_completion.d/docker-compose

# Run the pip script
./pip.sh
