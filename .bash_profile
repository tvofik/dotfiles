# Load dotfiles
for file in ~/.{bash_prompt,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Git
# Enable tab completion
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi
# Change command prompt
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

# Docker tab Completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Enable AWS tab completion
# complete -C '~/Library/Python/3.7/bin/aws_completer' aws

# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# export GIT_PS1_SHOWCOLORHINTS=1

# export PATH=~/.local/bin:$PATH
# export PATH="/usr/local/opt/python@3.8/bin:$PATH"