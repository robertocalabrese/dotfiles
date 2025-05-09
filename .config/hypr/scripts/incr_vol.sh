#!/usr/bin/env bash

# Increase volume
pamixer --increase 5
echo $(pamixer --get-volume) > ~/.cache/wob.socket