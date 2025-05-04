#!/bin/bash

# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

# Retrive the input parameters.
display=$1
wallpaper=$2

# Create a copy of the current wallpaper inside the cache folder.
cp "$wallpaper" ~/.cache/wallpaper/current.jpg