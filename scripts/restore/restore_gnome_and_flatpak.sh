#!/usr/bin/bash

set -euo pipefail

# Loading settings
dconf load /org/gnome/shell/extensions/ < "$HOME/dotfiles/gnome/extensions-dconf.ini"

# Re-installing applications
while read -r app; do
    flatpak install -y flathub "$app"
done < packages/flatpak.txt


echo "Done performing the restauration. Note that the extensions need to be installed separately since there is no CLI for it."
