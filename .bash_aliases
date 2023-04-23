### BASH ALIASES ###

alias show_bash_aliases='bat -l bash --paging=never ~/.bash_aliases'
alias show_fish_aliases='bat -l bash --paging=never ~/.config/fish/aliases.fish'
alias show_git_aliases='bat -l bash --paging=never ~/.config/git/.git_shell_aliases'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ls
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | rg "^\."'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=tty -d skip'
alias locate='plocate'

# adding flags to some very common commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias df='df -h'
alias free='free -m'
alias wget='wget -c'
alias mkdir='mkdir -p'

alias exe='chmod +x'
alias chownRoot='sudo chown root:root'
alias chownUser='sudo chown $USER:users'

# compress/decompress
alias compress='tar -cvpzf'
alias decompress='tar -xvpzf'

# World of Warcraft
alias kill_wow='killall WoW.exe'
alias kill_battlenet='killall Battle.net.exe'

# Root graphical settings
alias KDE='sudo dbus-launch systemsettings5'
alias GTK2='sudo lxappearance'
alias GTK3='sudo dconf-editor'
alias QT4='sudo qtconfig-qt4'
alias QT5='sudo qt5ct'

# pacman
alias update='sudo pacman -Syyu'
alias upgrade='yay -Syyua --noconfirm'
alias search='yay -Ss'
alias remove='sudo pacman -Rsn'
alias force_remove='sudo pacman -Rdd'

# makepkg related
alias Makepkg='makepkg -g >> PKGBUILD && makepkg -i'
alias AddKey='gpg --keyserver pool.sks-keyservers.net --recv-keys'
alias MD5='md5sum'

# reload all fonts
alias reload_fonts='fc-cache -fv && sudo fc-cache -fv'

# history
alias h='history | tac | bat'
alias hc='history -c | tac | bat'

# systemd
alias boot_time='systemd-analyze'
alias boot_chart='systemd-analyze blame'
alias running_services='systemctl list-unit-files | bat'
alias last_journal='sudo journalctl -b'
alias verify_journal='sudo journalctl --verify'
alias systemd_failed='systemctl --failed'

# camera
alias camera_detect='gphoto2 --auto-detect'
alias camera_summary='gphoto2 --summary'
alias camera_list='gphoto2 --list-files'
alias camera_get='gphoto2 --get-all-files'

# yt-dlp
alias youtube_video="yt-dlp --ignore-errors --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M' -f bestvideo+bestaudio"
alias youtube_song="yt-dlp -x --ignore-errors --external-downloader aria2c --external-downloader-args '-c -j 3 -x 3 -s 3 -k 1M' -f bestvideo+bestaudio --audio-format mp3 --audio-quality 320k"

# Shows all the shortcuts setted by 'Roberto Calabrese'.
alias shortcuts='bat -l bash --paging=never ~/shortcuts.txt'

# Keeps tracks of my dotfiles.
alias dotfile='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Keeps tracks of my configuration files.
alias myconfig='/usr/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME'

# Fossil
# fossil clone  URL nomefile.fossil
#   fossil clone  https://core.tcl-lang.org/tcl/dir?ci=tip core-8-7-b1-rc.fossil
#   fossil clone  https://core.tcl-lang.org/tk/dir?ci=tip  core-8-7-b1-rc.fossil
# fossil open   nomefile.fossil
#   fossil open core-8-7-b1-rc.fossil
# fossil update nomefile
#   fossil update trunk
#   fossil update core-8-7-b1-rc