#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"


# Custom colored Bash prompt with Git branch
parse_git_branch() {
  git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/ (\1)/'
}

# Colors
RESET="\[\e[0m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
CYAN="\[\e[36m\]"
MAGENTA="\[\e[35m\]"

# PS1 Format
export PS1="${CYAN}\u${RESET}@${BLUE}\h${RESET}:${MAGENTA}\w\$(parse_git_branch)${RESET}\$: "

# Aliases
alias ll='ls -la --color=auto'
alias general_pull='bash ~/Homo_Deus/Programming/Bash/git_general_pull.sh'
alias general_push='bash ~/Homo_Deus/Programming/Bash/git_general_push.sh'

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Starship
eval "$(starship init bash)"
