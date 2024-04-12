#!/bin/bash

if [[ "$(pacman -Qtdq)" ]]; then
    # Elimina tutte le versioni nella cache dei pacchetti installati
    yay -Scc

    sudo pacman -Rs $(pacman -Qtdq)
else
    echo "## Congratulations!! There are no orphaned packages in your system."
fi

# Save all the installed packages from the official repository into "~/.archlinuxPKGS.txt".
rm -f "$HOME/.archlinuxPKGS.txt"
pacman -Qnq > "$HOME/.archlinuxPKGS.txt"

# Save all the installed packages from the AUR repository into "~/.aurPKGS.txt".
rm -f "$HOME/.aurPKGS.txt"
pacman -Qmq > "$HOME/.aurPKGS.txt"

echo "## '~/.archlinuxPKGS.txt' and '~/.aurPKGS.txt' have been created."