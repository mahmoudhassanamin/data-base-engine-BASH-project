#!/bin/bash
DBdrop=$(zenity --entry --title "Drop DB" --text "drop" --entry-text "")
if [ -d Databases/$DBdrop ] && [[ $DBdrop == $rg0 || $DBdrop == $rg2 || $DBdrop == $rg3 || $DBdrop == $rg4 ]] && [[ $DBdrop == $rg5 ]]
then
rm -r Databases/$DBdrop
else
zenity --error --title "error" --text "error DB name not EXIST"
fi
