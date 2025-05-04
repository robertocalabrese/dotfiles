#!/bin/bash

USER="kicka"
DATA_CORRENTE=`date +%Y%m%d`
PREVISIONI=/home/${USER}/.cache/weather_forecast/${DATA_CORRENTE}

if [ -d /home/${USER}/.cache/weather_forecast ]; then
    echo "The weather forecast will be saved as '/home/${USER}/.cache/weather_forecast'"
else
    mkdir -p /home/${USER}/.cache/weather_forecast
fi

echo -n "Downloading weather forecast for Palermo on 'http://www.ilmeteo.it' ..."
wget -q http://www.ilmeteo.it/pdf/meteo-palermo.pdf -O ${PREVISIONI}_meteo-palermo.pdf

echo -n "Working some magicks ..."
pdftk ${PREVISIONI}_meteo-*.pdf cat output ${PREVISIONI}_meteo.pdf
rm ${PREVISIONI}_meteo-palermo.pdf
okular ${PREVISIONI}_meteo.pdf