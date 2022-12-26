#!/bin/bash
DBdrop=$(zenity --entry --title "Drop DB" --text "drop" --entry-text "")
if [ -d Databases/$DBdrop ] && [[ $DBdrop != "" && $DBdrop != *" "* && $DBconnect == $rg0 && $DBconnect == $rg2 && $DBconnect == $rg3 && $DBconnect == $rg4 ]]
then
rm -r Databases/$DBdrop
else
zenity --error --title "error" --text "error DB name not EXIST"
fi
