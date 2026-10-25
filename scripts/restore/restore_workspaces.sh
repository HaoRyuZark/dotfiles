#!/usr/bin/bash

set -euo pipefail

mkdir "$HOME/Homo_Deus/"
cd "$HOME/Homo_Deus/"

git clone git@github.com:HaoRyuZark/Mathematics_and_CS.git
git clone git@github.com:HaoRyuZark/Programming.git
git clone git@github.com:HaoRyuZark/Mathematica_Compendium.git

cd "$HOME/Documents/"

git clone git@github.com:HaoRyuZark/Notes.git

