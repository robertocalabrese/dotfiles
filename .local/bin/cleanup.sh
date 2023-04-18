#!/bin/bash

if [[ "$(pacman -Qtdq)" ]]; then
    # Elimina tutte le versioni nella cache dei pacchetti installati
    yay -Scc

    sudo pacman -Rs $(pacman -Qtdq)
else 
    echo "## Congratulations!! There are no orphaned packages in your system."
fi