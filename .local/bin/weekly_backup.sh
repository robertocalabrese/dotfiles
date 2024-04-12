#!/bin/bash

######################
# Incremental Backup #
######################

echo "Cleaning..."
sudo pacman -Scc

# Clean the trash bin.
trash-empty

# Remove any 0ad savings.
rm -rf /home/kicka/.local/share/0ad/replays
rm -rf /home/kicka/.local/share/0ad/saves

cd /

# Create the Weekly folder if it doesn't exist yet.
mkdir -p /mnt/Backups/Weekly

#echo "Checking the Backup mountpoint..."
#if [  -d "/mnt/Backups" ] ; then
#    sudo mkdir -p /mnt/Backups
#    sudo chown -R kicka:users /mnt/Backups
#fi

#echo "Mounting..."
#sudo mount UUID=71604311-25f3-44da-979e-c4c8356100b9 /mnt/Backups

# Optional rsync parameter: --dry-run
echo "Start the Weekly backup..."
sudo rsync -aAXv --delete   --exclude="/dev/*" \
                            --exclude="/home/kicka/Share/*" \
                            --exclude="/home/kicka/.cache/*" \
                            --exclude="lost+found" \
                            --exclude="/media/*" \
                            --exclude="/mnt/Backups/*" \
                            --exclude="/mnt/Storage/*" \
                            --exclude="/mnt/Video/*" \
                            --exclude="/mnt/VMs/*" \
                            --exclude="/proc/*" \
                            --exclude="/run/*" \
                            --exclude="/sys/*" \
                            --exclude="/tmp/*" \
                            / /mnt/Backups/Weekly

echo "Syncing..."
sync

#echo "Unmounting..."
#sudo umount /mnt/Backups

echo "Backup done."