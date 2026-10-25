#!/usr/bin/bash

set -euo pipefail

SCRIPTS=("./restore_gnome_and_flatpak.sh" "./restore_workspaces.sh")

for script in "${SCRIPTS[@]}"; do 
    bash "$script"
done

echo "Done performing the restauration of the settings and workspaces"
