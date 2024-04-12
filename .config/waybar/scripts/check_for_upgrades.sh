#!/usr/bin/env bash

# Puts the result of the command 'checkupdates | wc -l' inside a variable called PACKAGES
PACKAGES=$(checkupdates | wc -l)

if [[ "$PACKAGES" = "0" ]]; then
	# Do not show the icon on the waybar.
	exit 1
else
	# Show the icon on the waybar.
	exit 0
fi