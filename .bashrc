#
# ~/.bashrc
#

# Autostart X Graphic Shell
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s cdspell
shopt -s checkwinsize

##############################
## Export history variables ##
##############################

export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE='&amp;'
#export PATH='$HOME/.emacs.d/bin:$PATH'

## Git less
export LESS=-iXFR

########################################
## Export GTK2, GTK3 and QT variables ##
########################################

## Icon Settings
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

## GTK3 Fix for scrollbar that doesn't work after the window is loosing focus in KDE.
export GDK_CORE_DEVICE_EVENTS=1

## Options and characters
export QT_XFT="true"

## Better browser implementation in KDE.
export GTK_USE_PORTAL=1

##################################
## Export QT_PLATFORM variables ##
##################################

## Note: Uncomment only one of those.

## wayland
#export QT_QPA_PLATFORM="wayland;xcb"
#export XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland

## KDE
export QT_QPA_PLATFORMTHEME="kde"

## QT5
#export QT_QPA_PLATFORMTHEME="qt5ct"

## QT6
#export QT_QPA_PLATFORMTHEME="qt6ct"

############################
## Export HiDPI variables ##
############################

## KDE Panel scale factor.
export PLASMA_USE_QT_SCALING=1

## QT5 scale factor.
export QT_AUTO_SCREEN_SCALE_FACTOR=1

## GTK3 scale factors.
export GDK_SCALE=1
export GDK_DPI_SCALE=1.1

###############################################
## Export Desktop Environment 'DE' variables ##
###############################################

export DESKTOP_SESSION=plasma
export DE=plasma
export XDG_CURRENT_DESKTOP=plasma

## append to the history file, don't overwrite it.
#shopt -s histappend
#[[ "${PROMPT_COMMAND}" ]] && PROMPT_COMMAND="$PROMPT_COMMAND;history -a" || PROMPT_COMMAND="history -a"

################################
## Load aliases and functions ##
################################

# load the bash aliases, if any.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# load the git aliases, if any.
if [ -f ~/config/git/.git_shell_aliases ]; then
    . ~/config/git/.git_shell_aliases
fi

# load the bash functions, if any.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
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

########################
## Start a fish shell ##
########################

# setting the iteractive shell with fish instead of bash.
exec fish
