# Supresses fish's intro message
set fish_greeting

set -U fish_features regex-easyesc qmark-noglob ampersand-nobg-in-token

### EXPORT ###
set DATE (date -I)
set TERM "xterm-256color" # Sets the terminal type

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

#### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
#set fish_color_normal brcyan
#set fish_color_autosuggestion '#7d7d7d'
#set fish_color_command brcyan
#set fish_color_error '#ff6c6b'
#set fish_color_param brcyan

# load the fish aliases, if any.
if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
end

# load the git aliases, if any.
if test -f ~/.config/git/.git_shell_aliases
    source ~/.config/git/.git_shell_aliases
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

#if status is-interactive
#    # Commands to run in interactive sessions can go here
#end

# setting the starship prompt
starship init fish | source
