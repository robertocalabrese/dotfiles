## ~/config/fish/config.fish
#
# Developer:  🆁🅾🅱🅴🆁🆃🅾  🅲🅰🅻🅰🅱🆁🅴🆂🅴
# City:       🅿🅰🅻🅴🆁🅼🅾, 🆂🅸🅲🅸🅻🆈
# Country:    🅸🆃🅰🅻🆈

# Supresses fish's intro message
set fish_greeting

set -U fish_features regex-easyesc qmark-noglob ampersand-nobg-in-token

### EXPORT ###
set DATE (date -I)
set TERM "xterm-256color" # Sets the terminal type

# Load the KDE variables environment, if needed.
if [ "$DESKTOP_SESSION" = "plasma" ]
    set -x ELM_SCALE "1.0"

    #################################
    ## Export GTK2, GTK3 variables ##
    #################################

    # Icon Settings
    set -x GTK2_RC_FILES "$HOME/.gtkrc-2.0"

    # GTK3 Fix for scrollbar that doesn't work after the window is loosing focus in KDE.
    set -x GDK_CORE_DEVICE_EVENTS "1"

    # GTK3 scale factors.
    set -x GDK_SCALE "1"
    set -x GDK_DPI_SCALE "1.1"

    ####################################
    ## Export Plasma and QT variables ##
    ####################################

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

    ##################
    ## Wayland only ##
    ##################

    if [ "$XDG_SESSION_TYPE" = "wayland" ]
        set -x QT_QPA_PLATFORM "wayland;xcb"
        set -x GDK_BACKEND "wayland,x11"
        set -x CLUTTER_BACKEND wayland
        set -x QT_QPA_PLATFORM "wayland;xcb"
        set -x SDL_VIDEODRIVER wayland
    end
end

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

#### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
#set fish_color_normal brcyan
#set fish_color_autosuggestion '#7d7d7d'
#set fish_color_command brcyan
#set fish_color_error '#ff6c6b'
#set fish_color_param brcyan

# load the aliases, if any.
if test -f /home/kicka/.fish_aliases
  source /home/kicka/.fish_aliases
end

if test -f /home/kicka/.git_aliases
  source /home/kicka/.git_aliases
end

# Functions needed for !! and !$
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

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

if status is-interactive
  # Commands to run in interactive sessions can go here

  # Start X at login
  if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      exec startx -- -keeptty
  end
end

# setting the starship prompt
starship init fish | source
