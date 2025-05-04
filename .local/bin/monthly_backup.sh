#!/bin/bash

######################
# Incremental Backup #
######################

echo "Cleaning..."
sudo pacman -Scc

# Clean the trash bin.
trash-empty

cd /

# Create the Montly folder if it doesn't exist yet.
mkdir -p /mnt/Backups/Monthly

#echo "Checking the Backup mountpoint..."
#if [  -d "/mnt/Backups" ] ; then
#    sudo mkdir -p /mnt/Backups
#    sudo chown -R kicka:users /mnt/Backups
#fi

#echo "Mounting..."
#sudo mount UUID=71604311-25f3-44da-979e-c4c8356100b9 /mnt/Backups

# update tldr
tldr --update

# update pkgfile
sudo pkgfile --update

# Optional rsync parameter: --dry-run
echo "Start the Monthly backup..."
sudo rsync -aAXv --delete   --exclude="/dev/*" \
                            --exclude="/home/kicka/.cache/*" \
                            --exclude="/home/kicka/.local/share/*" \
                            --exclude="/home/kicka/.local/state/*" \
                            --exclude="/home/kicka/.local/opt/*" \
                            --exclude="lost+found" \
                            --exclude="/media/*" \
                            --exclude="/mnt/*" \
                            --exclude="/proc/*" \
                            --exclude="/run/*" \
                            --exclude="/sys/*" \
                            --exclude="/tmp/*" \
                            / /mnt/Backups/Monthly

echo "Syncing..."
sync

#echo "Unmounting..."
#sudo umount /mnt/Backups

echo "Backup done."