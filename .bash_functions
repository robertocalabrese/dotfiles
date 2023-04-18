### BASH FUNCTIONS ###

## ExtractAudio
#
# Author:       Roberto Calabrese & rootkode.com
# WebName:      Kicka
# Website:      http://rootkode.com
# Email:        robertocalabrese75@gmail.com
# License:      MIT License
# Date:         19-January-2014
function ExtractAudio() {
    VERSION="1.22"              # Versione Script
    RED="\e[1;31m"              # Rosso Grassetto
    GREEN="\e[1;32m"            # Verde Grassetto
    YELLOW="\e[1;33m"           # Giallo Grassetto
    RESET="\e[0m"               # Reset Color
    BITRATE="320k"              # Default Audio Bitrate 320k        Altri Valori:   32k 64k 128k 160k 192k 224k 256k
    FREQUENCY="44100"           # Default Audio Frequency 48000     Altri Valori:   44100 96000 192000
    AUDIO_EXT="mp3"             # Default Audio Extension mp3       Altri Valori:   AAC AC3 PCM FLAC
    FILENAME=$(basename "$1")   # Nome del File Video con Estensione (COMPLETO!)
    NAME="${FILENAME%.*}"       # Nome del File Video (SOLO IL NOME!)
    #EXT="${FILENAME##*.}"      # Estensione del File Video (SOLO L'ESTENSIONE!)

    # Controllo Parametri Comando
    if [[ -z "$1" ]]; then  # Se non c'e' un parametro dopo il comando ExtractAudio, visualizza le INFO & ESCI
        echo "Per eseguire ExtractAudio seguite la regola:"
        echo ""
        echo "ExtractAudio NomeDelFile    # Dove NomeDelFile e' il nome del vostro File Video"
        echo "                            # mettetelo fra \"\" se nel nome sono presenti degli spazi"
        echo "" 
        echo "Script:  ExtractAudio Script $VERSION"
        echo "Author:  Roberto Calabrese & rootkode.com"
        echo "Website: http://rootkode.com"
    else
        # Estrazione
        ffmpeg -i "$FILENAME" -vn -acodec $AUDIO_EXT -ab $BITRATE -ar $FREQUENCY "$NAME.$AUDIO_EXT"
        echo -e "${GREEN}Estrazione Audio Completata!${RESET}"
        echo -e "E' stato creato il nuovo File Audio:    ${GREEN}$NAME.$AUDIO_EXT ${RESET}"
        echo ""
        echo "Finito!"
    fi
}

## Mime updates.
#
# Author:       Roberto Calabrese & rootkode.com
# WebName:      Kicka
# Website:      http://rootkode.com
# Email:        robertocalabrese75@gmail.com
# License:      MIT License
# Date:         19-January-2014
function MimeUpdate() {
    VERSION="1.02"
    GREEN="\e[1;32m"
    RESET="\e[0m"

    # Update Mime Database.
    sudo rm -f /usr/share/mime/packages/kde.xml
    echo -e "${GREEN}Updating MIME database${RESET}"
    sudo update-mime-database /usr/share/mime
}

## Generatore di password.
#
# Author:       Roberto Calabrese & rootkode.com
# WebName:      Kicka
# Website:      http://rootkode.com
# Email:        robertocalabrese75@gmail.com
# License:      MIT License
# Date:         19-January-2014
function PassGen() {
    VERSION="2.05"                  # Versione Script

    ## Controllo Parametri Comando.
    if [[ -z "$1" ]]; then  # Se non c'e' nessun parametro dopo il comando PassGen, mostra le INFO & ESCI
        echo "INFO su PassGen Script:"
        echo ""
        echo "Utilizzo: PassGen [numero di caratteri]"
        echo ""
        echo "Script:  PassGen $VERSION"
        echo "Author:  Roberto Calabrese & rootkode.com"
        echo "Website: http://rootkode.com"
    else                    # Genera una Password contenente i seguenti caratteri: A-Z, a-z, 0-9, _<>!/()=?@#{}[]&%$^
        tr -dc 'A-Za-z0-9-_<>!/()=?@#{}[]&%$^' < /dev/urandom | head -c $1 | xargs
    fi
}

## smplayer
#
# Author:       Roberto Calabrese & rootkode.com
# WebName:      Kicka
# Website:      http://rootkode.com
# Email:        robertocalabrese75@gmail.com
# License:      MIT License
# Date:         19-January-2014
function smplayer() {
    # Disabilita KDE Screensaver e DPMS prima di lanciare smplayer
    # Riabilitazione alla fine di smplayer
    dcop kdesktop KScreensaverIface enable false
    xset -dpms
    /usr/bin/smplayer "$@"
    xset +dpms
    dcop kdesktop KScreensaverIface enable true
}

## SVG to PNG
#
# Author:       Roberto Calabrese & rootkode.com
# WebName:      Kicka
# Website:      http://rootkode.com
# Email:        robertocalabrese75@gmail.com
# License:      MIT License
# Date:         19-January-2014
function SvgPng() {
    BG="1"

    if [[ -n "$1" ]]; then
        INPUT="$1.svg"
        OUTPUT="$1.png"

        if [[ -n "$2" ]]; then
            if [[ $2 == "none" ]]; then
                BACKGROUND="#FFFFFF"
                BG="0"
            else
                BACKGROUND="#$2"
            fi
        else
            BACKGROUND="#FFFFFF"
            BG="0"
        fi
        if [[ -n "$3" ]]; then
            WIDTH="$3"
        else
            WIDTH="32"
        fi
        if [[ -n "$4" ]]; then
            HEIGHT="$4"
        else
            HEIGHT="$3"
        fi
        
        if [[ -n "$5" ]]; then
            OPACITY="$5"
        else
            OPACITY="1.0"
        fi
    
        # Debug
        echo "BACKGROUND: $BACKGROUND"
        echo "WIDTH: $WIDTH"
        echo "HEIGHT: $HEIGHT"
        echo "OPACITY: $OPACITY"

        inkscape $INPUT -z -w $WIDTH -h $HEIGHT -b "$BACKGROUND" -y $OPACITY -e $OUTPUT
        
        if [[ $BG == "0" ]]; then
            convert $OUTPUT -transparent "#FFFFFF" $OUTPUT
        fi
    else
        echo "SVG to PNG"
        echo ""
        echo "command:    SvgPng filename background width height opacity"
        echo "Where..."
        echo "filename    is the filename of the image without the extension"
        echo "background  is the output image background color. Type none if you want a transparent background."
        echo "width       is the output image width. If it's not setted, it will be 32 pixel"
        echo "height      is the output image height. If it's not setted, it will be the same as the width"
        echo "opacity     is the output opacity. If it's not setted, it will be 1.0 (completely opaque, no transparent)"
        echo ""
    fi
}