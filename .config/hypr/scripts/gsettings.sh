#!/bin/sh

# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

if [ ! -f "$HOME/.config/gtk-3.0/settings.ini" ]; then
    if [ ! -f "$HOME/.config/gtk-4.0/settings.ini" ]; then
        exit 1
    else
        gtk_settings="$HOME/.config/gtk-4.0/settings.ini"
    fi
else
    gtk_settings="$HOME/.config/gtk-3.0/settings.ini"
fi

gtk_theme="$(grep 'gtk-theme-name' "$gtk_settings" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$gtk_settings" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$gtk_settings" | sed 's/.*\s*=\s*//')"
cursor_size="$(grep 'gtk-cursor-theme-size' "$gtk_settings" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$gtk_settings" | sed 's/.*\s*=\s*//')"

gsettings set "org.gnome.desktop.interface" gtk-theme           "$gtk_theme"
gsettings set "org.gnome.desktop.interface" icon-theme          "$icon_theme"
gsettings set "org.gnome.desktop.interface" cursor-theme        "$cursor_theme"
gsettings set "org.gnome.desktop.interface" cursor-size         "$cursor_size"
gsettings set "org.gnome.desktop.interface" font-name           "$font_name"
gsettings set "org.gnome.desktop.interface" color-scheme        "prefer-dark"
gsettings set "org.gnome.desktop.interface" text-scaling-factor "1.0"