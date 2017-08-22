#!/bin/bash

# Was dieses Script macht:
# Archive nach dem Downloaden entpacken,
# Dateitypen aus Unterverzeichnissen nach
# Ordnernamen umbennen und ins übergeordnete Verz. verschieben

# Bsp: vs-am.wilden.fluss.1080p.rar-r50
# -> Die Datei .rar entpacken, danach die entpackte Datei nach Ordnernamen umbennen und ins ../ verschieben.
# Ergebis: Dateiname: Am.wilden.Fluss.1994.German.DL.1080p.BluRay.x264.iNTERNAL-VideoStar.mkv
# Rest wie sample und .nfo wird gelöscht

# doc_gonzo mai 2017

# input = Dateityp in variable ext

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



#dateimaske:
#ext=rar

type=$(echo "*.$ext")
echo
echo -e "DATEITYP ist $cblue$type"$cdefault
echo

#Rechte holen von Verzeichnissen und Dateien
find . -type d -exec chmod 755 {} +
find . -type f -exec chmod 644 {} +

#ordner einlesen
IFS=$'\n'
folder=( $(find -maxdepth 1 -type d) )
##gerart=( $(find -type f|grep -m 1 rar) ) # zur Info
echo -e "Anzahl der gefundenen Ordner $cblue${#folder[@]}"$cdefault
##echo -e "RAR Datei {gerart[@]}" # zur Info
# Anzahl der zu entpackenden Dateien ist mit ".." also eins abziehen
unset folder[0]


echo "Benenne $ext-Dateien um...."
echo

for i in "${folder[@]}"; do

    cd "${i:2}"
    
	filecount=( $(find ./ -maxdepth 1 -type f -name rar | wc -l) )

    if [ $filecount -gt 1 ]; then
        echo -e $cred"Fehler: mehr als eine $ext-Datei in "$i" gefunden"
        printf $cdefault
        cd ..
    else
        printf $cdefault
	if [ "$(find -type f|grep -m 1 rar)" ]
  		then
    		for a in *.rar; do
			echo -e $cblue"Es wird entpackt: "$a""$cdefault""
			unrar x -o- "$a" 2> /dev/null | grep "All OK"
					#id 2>/dev/null 1>/dev/null
			printf $cgreen
		mv -v *.$ext ../"${i:2}".$ext
		done
		
fi	        
	      printf $cdefault
        cd ..
       # rm -f -R "${i:2}"
       # Verzeichnis nach erfolgreichem entpacken löschen;
       # kann man muss man nicht
    fi
done

echo -e "$default----------------------------------------------------"

