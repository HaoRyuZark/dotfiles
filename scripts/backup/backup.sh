#!/usr/bin/bash

set -euo pipefail

SCRIPTS=("./backup_gnome.sh")

for script in "${SCRIPTS[@]}"; do 
    bash "$script"
done

echo "Done performing the backup"
