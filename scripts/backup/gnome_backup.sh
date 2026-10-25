#!/usr/bin/bash

set -euo pipefail 

# Backup keybinds and settings
dconf dump /org/gnome/ > "$HOME/dotfiles/gnome/dconf.ini"

# Backup extension list (NO installation yet)
gnome-extensions list > "$HOME/dotfiles/gnome/extensions.txt"

# Backup extensions settings 
dconf dump /org/gnome/shell/extensions > "$HOME/dotfiles/gnome/extension-dconf.ini"

# Backup Flatpak
flatpack list --app --columns=application > "$HOME/dotfiles/flatpak/flatpak.txt"

echo "Backup of the GNOME default and extension settings, and flatpack packages list completed completed."


