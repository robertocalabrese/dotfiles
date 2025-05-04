# Author:  Roberto Calabrese a.k.a. Kicka
# City:    Palermo, Sicily
# Country: Italy

set DATE (date -I)
set TERM "xterm-256color" # Sets the terminal type

# Supresses fish's intro message
set fish_greeting

# Make the following variables universal.
set -U fish_features regex-easyesc qmark-noglob ampersand-nobg-in-token

##############################
##                          ##
##     EXPORT VARIABLES     ##
##                          ##
##############################

# Manpager
set -x  MANPAGER "sh -c 'col -bx | bat -l man --paging=never'"

# Editor
set -x EDITOR "micro"
set -x MICRO_TRUECOLOR "1"

# Export the following variables environment, if we are on KDE PLASMA.
if [ "$DESKTOP_SESSION" = "plasma" ]
    set -x ELM_SCALE "1.0"

    #########################################
    ##                                     ##
    ##     EXPORT GTK2, GTK3 VARIABLES     ##
    ##                                     ##
    #########################################

    # Icon Settings
    set -x GTK2_RC_FILES "~/.gtkrc-2.0"

    # GTK3 Fix for scrollbar that doesn't work after the window is loosing focus in KDE.
    set -x GDK_CORE_DEVICE_EVENTS "1"

    # GTK3 scale factors.
    set -x GDK_SCALE "1"
    set -x GDK_DPI_SCALE "1.1"

    ############################################
    ##                                        ##
    ##     EXPORT PLASMA AND QT VARIABLES     ##
    ##                                        ##
    ############################################

    # Options and characters
    set -x QT_XFT "true"

    ## Plasma Panel scale factor.
    #set PLASMA_USE_QT_SCALING "1"

    ## QT scale factor.
    set -x QT_AUTO_SCREEN_SCALE_FACTOR "1"
    set -x QT_ENABLE_HIGHDPI_SCALING "1"
    set -x QT_SCALE_FACTOR "1.0"
    #set -x QT_FONT_DPI "144"

    # Better browser implementation in KDE.
    set -x GTK_USE_PORTAL "1"

    ##########################
    ##                      ##
    ##     WAYLAND ONLY     ##
    ##                      ##
    ##########################

    if [ "$XDG_SESSION_TYPE" = "wayland" ]
        set -x QT_QPA_PLATFORM "wayland;xcb"
        set -x GDK_BACKEND "wayland,x11"
        set -x CLUTTER_BACKEND wayland
        set -x QT_QPA_PLATFORM "wayland;xcb"
        set -x SDL_VIDEODRIVER wayland
    end
end

###############################################
##                                           ##
##     AUTOCOMPLETE AND HIGHLIGHT COLORS     ##
##                                           ##
###############################################

#set fish_color_normal brcyan
#set fish_color_autosuggestion '#7d7d7d'
#set fish_color_command brcyan
#set fish_color_error '#ff6c6b'
#set fish_color_param brcyan

##############################
##                          ##
##     LOAD THE ALIASES     ##
##                          ##
##############################

if test -f /home/kicka/.fish_aliases
  source /home/kicka/.fish_aliases
end

if test -f /home/kicka/.git_aliases
  source /home/kicka/.git_aliases
end

#####################################
##                                 ##
##     FUNCTIONS FOR !! AND !$     ##
##                                 ##
#####################################

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

########################################
##                                    ##
##     BINDINGS FOR FOR !! AND !$     ##
##                                    ##
########################################

if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

################################
##                            ##
##     ITERACTIVE SECTION     ##
##                            ##
################################

if status is-interactive
  # Commands to run in interactive sessions can go here

  # Start X at login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      exec startx -- -keeptty
  end
end

##############################
##                          ##
##     LAUNCH FASTFETCH     ##
##                          ##
##############################

fastfetch

#####################################
##                                 ##
##     SET THE STARSHIP PROMPT     ##
##                                 ##
#####################################

starship init fish | source