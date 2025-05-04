# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s cdspell
shopt -s checkwinsize

##############################
##                          ##
##     EXPORT VARIABLES     ##
##                          ##
##############################

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE='&amp;'

# Manpager
export MANPAGER="sh -c 'col -bx | bat -l man --paging=never'"

# Editor
export EDITOR="micro"
export MICRO_TRUECOLOR=1

# Export the following variables environment, if we are on KDE PLASMA.
if [[ "$DESKTOP_SESSION" = "plasma" ]]; then
    export ELM_SCALE=1.0

    #########################################
    ##                                     ##
    ##     EXPORT GTK2, GTK3 VARIABLES     ##
    ##                                     ##
    #########################################

    # Icon Settings
    export GTK2_RC_FILES="~/.gtkrc-2.0"

    # GTK3 Fix for scrollbar that doesn't work after the window is loosing focus in KDE.
    export GDK_CORE_DEVICE_EVENTS=1

    # GTK3 scale factors.
    export GDK_SCALE=1
    export GDK_DPI_SCALE=1.1

    ############################################
    ##                                        ##
    ##     EXPORT PLASMA AND QT VARIABLES     ##
    ##                                        ##
    ############################################

    # Options and characters
    export QT_XFT="true"

    ## QT scale factor.
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_ENABLE_HIGHDPI_SCALING=1
    export QT_SCALE_FACTOR=1.0

    # Better browser implementation in KDE.
    export GTK_USE_PORTAL=1

    ##########################
    ##                      ##
    ##     WAYLAND ONLY     ##
    ##                      ##
    ##########################

    if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
        export QT_QPA_PLATFORM="wayland;xcb"
        export GDK_BACKEND="wayland,x11"
        export CLUTTER_BACKEND=wayland
        export QT_QPA_PLATFORM="wayland;xcb"
        export SDL_VIDEODRIVER=wayland
    fi
fi

##########################
##                      ##
##     LOAD ALIASES     ##
##                      ##
##########################

# bash
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# git
if [ -f ~/.git_aliases ]; then
    source ~/.git_aliases
fi

#####################################
##                                 ##
##     SET THE STARSHIP PROMPT     ##
##                                 ##
#####################################

eval "$(starship init bash)"