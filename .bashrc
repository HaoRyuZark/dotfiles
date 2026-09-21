# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# User binaries
export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/.juliaup/bin:$PATH"

export EDITOR="/usr/bin/nvim" 

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Neovim as man pages reader
export MANPAGER="nvim +Man!"

# starship
eval "$(starship init bash)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Aliases
alias ll='ls -la --color=auto'
alias gp='bash $HOME/dotfiles/scripts/gp.sh'
alias nvimdiff='nvim -d'
alias audio='pavucontrol'
alias homo='cd $HOME/Homo_Deus; tmux'

# Haskell Set-up
# [ -f "/home/miguel/.ghcup/env" ] && . "/home/miguel/.ghcup/env" # ghcup-env

# Load Angular CLI autocompletion. (Can cause slow startup)
#source <(ng completion script)
