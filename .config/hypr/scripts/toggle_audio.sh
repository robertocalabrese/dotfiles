#!/usr/bin/env bash

# Toggle Audio
if [ "$(pamixer --get-mute)" == "false" ]; then
    pamixer -m
elif [ "$(pamixer --get-mute)" == "true" ]; then
    pamixer -u
fi