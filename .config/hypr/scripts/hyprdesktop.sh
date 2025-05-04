#!/usr/bin/env bash

# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

# Kill all running portals.
sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal-kde
killall xdg-desktop-portal

# Start all the portals again in the following order.
sleep 1
/usr/lib/xdg-desktop-portal-hyprland &
/usr/lib/xdg-desktop-portal-gtk &
/usr/lib/xdg-desktop-portal-kde &
sleep 2
/usr/lib/xdg-desktop-portal &