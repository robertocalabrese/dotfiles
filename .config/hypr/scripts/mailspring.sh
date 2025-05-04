#!/usr/bin/env bash

# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

killall mailspring
sleep 1
mailspring --background --password-store="gnome-libsecret"