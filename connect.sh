#!/bin/bash
DBconnect=$(zenity --entry --title "connecting..." --text "enter DB Name" --width 300)
if [ -d Databases/"$DBconnect" ] && [[ $DBconnect == $rg0 || $DBconnect == $rg2 || $DBconnect == $rg3 || $DBconnect == $rg4 ]] && [[ $DBconnect != $rg5 ]]
then
zenity --info --text "connection succeeded"
. DBconnected.sh
else
zenity --error --title "error" --text "no DB exist as this name"
fi
