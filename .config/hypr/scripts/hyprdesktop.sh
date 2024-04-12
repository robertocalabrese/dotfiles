#!/usr/bin/env bash

# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

sleep 1

# kill all possible running xdg-desktop-portals
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-gtk
killall xdg-desktop-portal-kde
#killall xdg-desktop-portal-gnome
#killall xdg-desktop-portal-kde
#killall xdg-desktop-portal-lxqt
#killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
sleep 1

# start xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal-hyprland &
#/usr/lib/xdg-desktop-portal-gtk &
#/usr/lib/xdg-desktop-portal-kde &
sleep 2

# start xdg-desktop-portal
/usr/lib/xdg-desktop-portal &
sleep 1
