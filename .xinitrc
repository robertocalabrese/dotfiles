#!/bin/sh
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

##########################
## DEFAULT APPLICATIONS ##
##########################

## Editor (Sublime if there is a GUI, or nano if it doesn't)
if [[ -n "$DISPLAY" ]]; then
    export EDITOR="subl"
else
    export EDITOR="nano"
fi

## Browser (Only if there is a GUI)
if [[ -n "$DISPLAY" ]]; then
    export BROWSER="/usr/bin/brave"
fi

#######################
## GTK2, GTK3 and QT ##
#######################

## Icon Settings
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

## GTK3 Fix for scrollbar that doesn't work after the window is loosing focus in KDE.
export GDK_CORE_DEVICE_EVENTS=1

## Options and characters
export QT_XFT="true"

## Better browser implementation in KDE.
export GTK_USE_PORTAL=1

#################
## QT_PLATFORM ##
#################

## Note: Uncomment only one of those.

## wayland
#export QT_QPA_PLATFORM="wayland;xcb"
#export XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland

## KDE
export QT_QPA_PLATFORMTHEME="kde"

## QT5
#export QT_QPA_PLATFORMTHEME="qt5ct"

## QT6
#export QT_QPA_PLATFORMTHEME="qt6ct"

###########
## HiDPI ##
###########

## KDE Panel scale factor.
export PLASMA_USE_QT_SCALING=1

## QT5 scale factor.
export QT_AUTO_SCREEN_SCALE_FACTOR=1

## GTK3 scale factors.
export GDK_SCALE=1
export GDK_DPI_SCALE=1.1

##############################
## Desktop Environment 'DE' ##
##############################

export DESKTOP_SESSION=plasma
export DE=plasma
export XDG_CURRENT_DESKTOP=plasma

##########
## HTTP ##
##########

#export CDPATH=".:~:/srv/http"

########################
## Screensaver ON/OFF ##
########################

## Note: Only for DE without energy management features.

## Screensaver ON
#xset s blank &
#xset s 600 &
#xset dpms 0 0 1200 &

## Screensaver OFF
#xset -dpms &

##########################
## Loads "~/.Xresource" ##
##########################

xrdb ~/.Xresources &

################
## VirtualBox ##
################

#/usr/bin/VBoxClient-all &

################################
## Loads the italian keyboard ##
################################

setxkbmap -layout it &

##############################################
## Mount SerieTV1 and SerieTV2 into SerieTV ##
##############################################

#unionfs /mnt/SerieTV2=rw:/mnt/SerieTV1=rw /mnt/SerieTV

#################
## DE starters ##
#################

## Note: Uncomment only one of those.

## Start KDE Plasma-x11
exec startplasma-x11

## Start KDE Plasma-wayland
#exec startplasma-wayland