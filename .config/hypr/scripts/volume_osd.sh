#!/bin/bash

# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

# Start wob and make it listen '~/.cache/wob.socket'.
rm -f ~/.cache/wob.socket
mkfifo ~/.cache/wob.socket
pidof wob || tail -f ~/.cache/wob.socket | wob