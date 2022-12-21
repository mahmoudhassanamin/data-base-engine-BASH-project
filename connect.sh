#!/bin/bash
DBconnect=$(zenity --entry --title "connecting..." --text "enter DB Name" --width 300)
if [ -d Databases/"$DBconnect" ] && [[ $DBconnect != "" && $DBconnect != *" "* && $DBconnect != $rg0 ]]
then
zenity --info --text "connection succeeded"
. DBconnected.sh
else
zenity --error --title "error" --text "no DB exist as this name"
fi
