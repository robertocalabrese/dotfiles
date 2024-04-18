#!/usr/bin/env bash

# Check the result of the command 'checkupdates | wc -l'.
if [[ $(checkupdates | wc -l) = "0" ]]; then
	# Do not show the icon on the waybar.
	exit 1
else
	# Show the icon on the waybar.
	exit 0
fi