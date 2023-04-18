### ALIASES ###

alias show_bash_aliases='bat -l bash --paging=never ~/.bash_aliases'
alias show_fish_aliases='bat -l bash --paging=never ~/.config/fish/aliases.fish'
alias show_git_aliases='bat -l bash --paging=never ~/.config/git/.git_shell_aliases'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a  --color=always --group-directories-first' # all files and dirs
alias ll='exa -l  --color=always --group-directories-first' # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | rg "^\."'

# pacman and yay
alias pacman_unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='/home/$USER/.local/bin/cleanup.sh'       # remove orphaned packages

# get fastest mirrors
alias update_mirrors="sudo reflector --latest 50 --protocol https --age 12 --sort rate --country France,Germany,Italy --verbose --save /etc/pacman.d/mirrorlist"

# update pkgfile
alias update_pkgfile='sudo pkgfile --update'

# colorize grep output
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# launch a bash shell with no preconfigured bash options.
alias bash_shell='bash --rcfile ~/.bashrc-no-fish-shell'

# plocate instead of locate
alias locate='plocate'

# chown
alias chownRoot='sudo chown root:root'
alias chownUser='sudo chown $USER:users'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias wget='wget -c'                      # download from internet
alias mkdir='mkdir -p'                    # if the folder exists allready, do nothing
alias exe='chmod +x'                      # makes a file executable
alias bat='bat --paging=never'

# system configures
alias KDE='sudo dbus-launch systemsettings5'
alias GTK2='sudo lxappearance'
alias GTK3='sudo dconf-editor'
alias QT4='sudo qtconfig-qt4'
alias QT5='sudo qt5ct'
alias reload_fonts='fc-cache -fv && sudo fc-cache -fv'

# camera
alias camera_detect='gphoto2 --auto-detect'
alias camera_summary='gphoto2 --summary'
alias camera_list='gphoto2 --list-files'
alias camera_get='gphoto2 --get-all-files'

# compress/decompress
alias compress='tar -cvpzf'
alias decompress='tar -xvpzf'

# Fossil
# fossil clone  URL nomefile.fossil
#   fossil clone  https://core.tcl-lang.org/tcl/dir?ci=tip core-8-7-b1-rc.fossil
#   fossil clone  https://core.tcl-lang.org/tk/dir?ci=tip  core-8-7-b1-rc.fossil
# fossil open   nomefile.fossil
#   fossil open core-8-7-b1-rc.fossil
# fossil update nomefile
#   fossil update trunk
#   fossil update core-8-7-a3-rc
# fossil sync
#   fossil sync

# gpg encryption
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"             # verify signature for isos
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"    # receive the key of a developer

# yt-dlp
alias youtube_video='yt-dlp --ignore-errors --external-downloader aria2c --external-downloader-args \'-c -j 3 -x 3 -s 3 -k 1M\' -f bestvideo+bestaudio'
alias youtube_song='yt-dlp -x --ignore-errors --external-downloader aria2c --external-downloader-args \'-c -j 3 -x 3 -s 3 -k 1M\' -f bestvideo+bestaudio --audio-format mp3 --audio-quality 320k'

# Shows all the shortcuts setted by 'Roberto Calabrese'.
alias shortcuts='bat -l bash --paging=never ~/shortcuts.txt'

# Keeps tracks of my dotfiles.
alias dotfile='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Keeps tracks of my configuration files.
alias myconfig='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'

# restart virtualbox demon
alias restart_virtualbox='sudo /sbin/rcvboxdrv setup'

# World of Warcraft
alias kill_wow='killall WoW.exe'
alias kill_battlenet='killall Battle.net.exe'