#!/usr/bin/env bash

# Decrease volume
pamixer --decrease 5
echo $(pamixer --get-volume) > ~/.cache/wob.socket