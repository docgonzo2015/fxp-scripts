#!/bin/bash

# .STRM Dateien für Kodi-Gdrive-Plugin erzeugen
# input: gdriveverzeichnis.txt
# ausgabe: dateiname.strm mit verlinkung auf gdrive kodi plugin anstatt dateiname.mkv

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

regex="[^/]*$" # Nach dem letzten " / " suchen

for line in `cat gdriveverzeichnis.txt`
do
line=$(echo $line | grep -oP "$regex" | sed "s/.mkv//g")
line=$(echo $line | grep -oP "$regex")
#$dateiname="$(line | grep -oP '$regex' | sed "s/.avi//g ))"
echo "plugin://plugin.video.gdrive?mode=playvideo&title="$line."mkv" > $line".strm";
#echo $line
#echo "plugin://plugin.video.gdrive?mode=playvideo&title="$dateiname."avi" > $dateiname".strm";
done

IFS=$SAVEIFS
