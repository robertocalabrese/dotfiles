#!/bin/bash

# ##########################
# ##                      ##
# ##     HYPRSHOT-GUI     ##
# ##                      ##
# ##########################

OPTION=()

values=$(zenity \
    --title="Hyprshot GUI" \
    --text="Options" \
    --forms \
    --add-combo="Mode [default: whole screen]" \
    --combo-values="Whole screen|Specific window|Specific area" \
    --add-entry="Time to wait [default: 0s]" \
    --add-combo="Save to [default: both]" \
    --combo-values="Clipboard and file|Clipboard only" \
    --add-combo="Monitor [Whole screen only]" \
    --combo-values="$(hyprctl -j monitors | jq -r 'map(.name) | join("|")')" \
    --add-combo="Directory to save screenshot" \
    --combo-values="~/Screenshots|Select directory" \
) 2>/dev/null

result=$?

mode=$(echo $values | cut -d '|' -f 1)
wait=$(echo $values | cut -d '|' -f 2)
clipboard=$(echo $values | cut -d '|' -f 3)
monitor=$(echo $values | cut -d '|' -f 4)
directory=$(echo $values | cut -d '|' -f 5)

if [ "$result" -eq 1 ]; then  # select cancel
    echo "Cancelled"
    exit
fi

if [ "$directory" == "Select directory" ]; then
    FILEDIR=$(zenity --file-selection --directory --title="Choose directory to save screenshot")

    if [ "$?" -eq 1 ]; then
        FILEDIR="$HOME/Screenshots"
    fi
else
    FILEDIR="$HOME/Screenshots"
fi


if [ ! -z "$wait" ]; then
    sleep $wait
fi

FILENAME="Screenshot_$(date +%F_%H.%M.%S).png"

if [ "$mode" == "Specific window" ]; then  # select specify window
    MODE_OPTION="-m window"
elif [ "$mode" == "Specific area" ]; then  # select specfy area
    MODE_OPTION="-m region"
else
    MODE_OPTION="-m output"
fi

if [ ! -z "$monitor" ]; then
    MODE_OPTION+=(" -m $monitor")
fi


if [ "$clipboard" == "Clipboard only" ]; then
    hyprshot $MODE_OPTION --clipboard-only
else
    hyprshot $MODE_OPTION -o $FILEDIR -f $FILENAME
fi
