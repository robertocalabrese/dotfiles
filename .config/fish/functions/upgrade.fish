function upgrade
    # Upgrades the entire system (OFFICIAL PKGS and AUR PKGS)
    command yay -Syyu --needed --noconfirm

    # Backups all the packages installed from the official repository into "$HOME/pacman.txt".
    command rm -f "$HOME/pacman.txt"
    command pacman -Qnq > "$HOME/pacman.txt"

    echo (set_color green) "### 'pacman.txt' updated ###" (set_color normal)

    # Backups all the packages installed from the AUR repository into "$HOME/aur.txt".
    command rm -f "$HOME/aur.txt"
    command pacman -Qmq > "$HOME/aur.txt"

    echo (set_color green) "### 'aur.txt' updated ###" (set_color normal)
end