## ~/.bashrc
#
# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

## Autostart X Graphic Shell
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s cdspell
shopt -s checkwinsize

## append to the history file, don't overwrite it.
#shopt -s histappend
#[[ "${PROMPT_COMMAND}" ]] && PROMPT_COMMAND="$PROMPT_COMMAND;history -a" || PROMPT_COMMAND="history -a"

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE='&amp;'

#################
## Add to PATH ##
#################

#export PATH='$HOME/.emacs.d/bin:$PATH'

##########################
## DEFAULT APPLICATIONS ##
##########################

# Editor
export EDITOR="micro"

# Browser
if [[ -n "$DISPLAY" ]]; then
    export BROWSER="/usr/bin/firefox"
fi

# Git less
export LESS=-iXFR

if [[ "$DESKTOP_SESSION" = "plasma" ]]; then
    export ELM_SCALE = 1.0

    #################################
    ## Export GTK2, GTK3 variables ##
    #################################

    # Icon Settings
    export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

    # GTK3 Fix for scrollbar that doesn't work after the window is loosing focus in KDE.
    export GDK_CORE_DEVICE_EVENTS=1

    # GTK3 scale factors.
    export GDK_SCALE=1
    export GDK_DPI_SCALE=1.1

    ####################################
    ## Export Plasma and QT variables ##
    ####################################

    # Options and characters
    export QT_XFT="true"

    ## Plasma Panel scale factor.
    #export PLASMA_USE_QT_SCALING=1

    ## QT scale factor.
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_ENABLE_HIGHDPI_SCALING=1
    export QT_SCALE_FACTOR=1.0
    #export QT_FONT_DPI=144

    # Better browser implementation in KDE.
    export GTK_USE_PORTAL=1

    ##################
    ## Wayland only ##
    ##################

    if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
        export QT_QPA_PLATFORM="wayland;xcb"
        export GDK_BACKEND="wayland,x11"
        export CLUTTER_BACKEND=wayland
        export QT_QPA_PLATFORM="wayland;xcb"
        export SDL_VIDEODRIVER=wayland
    fi
fi

##################
## Load aliases ##
##################

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.git_aliases ]; then
    . ~/.git_aliases
fi

#########################
## Start the SSH agent ##
#########################

#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
#fi
#if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
#    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
#fi

#############################
## Set the starship prompt ##
#############################

eval "$(starship init bash)"
