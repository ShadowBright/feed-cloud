Xaxis=$(xrandr --current 2>/dev/null | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
Yaxis=$(xrandr --current 2>/dev/null | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)

docker run --rm="true" -e SCR_WDTH=${Xaxis} -e SCR_HGHT=${Yaxis} -e OUTPUT_DIR='/background' -v ${PWD}/background:/background -it feed_cloud sh run.sh  

sudo chmod 777 ${PWD}/background/feedWordBag.jpg

#does this even work ?
gconftool-2 -t str --set /desktop/gnome/background/picture_filename "${PWD}/background/feedWordBag.jpg" >/dev/null 2>/dev/null

#workds on gnome desktop..sometimes
gsettings set org.gnome.desktop.background picture-uri "file://${PWD}/background/feedWordBag.jpg" >/dev/null 2>/dev/null


# osx caches background...so have to change it before setting background image to something with same filename again
osascript -e 'tell application "System Events" to set picture of every desktop to ("/Library/Desktop Pictures/Solid Colors/Solid Gray Dark.png" as POSIX file as alias)' 2>/dev/null

sleep 1

# works on osx
osascript -e 'tell application "System Events" to set picture of every desktop to ("'${PWD}/'background/feedWordBag.jpg" as POSIX file as alias)' >/dev/null 2>/dev/null  
