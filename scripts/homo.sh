#!/usr/env bash

set -euo pipefail

SESSION="work"

# Session starter
tmux new-session -d -s "$SESSION" -n "Data" -c "$HOME/Homo_Deus/Data_Science/"

# Windows
tmux new-window -t "$SESSION" -n "Programming" -c "$HOME/Homo_Deus/Programming/"
tmux new-window -t "$SESSION" -n "Mathematica" -c "$HOME/Homo_Deus/Mathematica_Compendium/"
tmux new-window -t "$SESSION" -n "Books" -c "$HOME/Homo_Deus/Mathematics_and_CS/"

tmux select-window -t "$SESSION:1"

tmux attach-session -t "$SESSION"


