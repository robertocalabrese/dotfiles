#!/usr/bin/env bash

# Toggle Mic
if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
    pamixer --default-source -m
elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
    pamixer -u --default-source u
fi