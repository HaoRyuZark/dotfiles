# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi


export PATH="$PATH:/home/miguel/.cargo/bin" 

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

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/miguel/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/miguel/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

# Aliases
alias ll='ls -la --color=auto'
alias gp='bash $HOME/Homo_Deus/Programming/Bash/scripts/gp.sh'
alias gkey='$HOME/Homo_Deus/Programming/Bash/scripts/store_key_binds.sh'
alias gset='$HOME/Homo_Deus/Programming/Bash/scripts/store_gnome_settings.sh'

