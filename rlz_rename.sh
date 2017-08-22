#!/bin/bash

# Was dieses Script macht:
# Dateitypen aus Unterverzeichnissen nach
# Ordnernamen umbennen und ins übergeordnete Verz. verschieben

# doc_gonzo mai 2017

#input = Dateityp in variable ext

# Farben:
cred='\e[1;31m'
cgreen='\033[1;32m'
cblue='\033[36m'
cdefault='\033[0m'

echo -e "Welcher DATEITYP soll bearbeiten werden? Standard ist "$cgreen"mkv"$cdefault
read -p "avi|mp4|mkv: " ext
case "$ext" in
        "") 
             ext=mkv
             #type=$(echo "*.$ext")

            ;;
        avi|mp4|mkv) type=$(echo "*.$ext")
            ;;
        
        *) echo "Falscher DATEITYP!" 
            exit 1
            ;;
esac


#dateimaske: ext=(Standard) mkv
type=$(echo "*.$ext")
echo
echo -e "DATEITYP ist $cblue$type"$cdefault
echo

#ordner einlesen

IFS=$'\n'
folder=( $(find -maxdepth 1 -type d) )
#echo -e "Anzahl der gefundenen Ordner $cblue${#folder[@]}"$cdefault

# Anzahl ist mit ".." also eins abziehen

unset folder[0]


echo "Benenne $ext-Dateien um...."
echo

for i in "${folder[@]}"; do

    cd "${i:2}"
    filecount=( $(find ./ -maxdepth 1 -type f -name "$type" | wc -l) )

    if [ $filecount -gt 1 ]; then
        echo -e $cred"Fehler: mehr als eine $ext-Datei in "$i" gefunden"
        printf $cdefault
        cd ..
    else
        printf $cgreen
        mv -v *.$ext ../"${i:2}".$ext
        printf $cdefault
        cd ..
       # rm -f -R "${i:2}"
       # kann man muss man nicht
    fi
done

echo -e "$default----------------------------------------------------"
