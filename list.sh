#!/bin/bash
if [[ -d "Databases" ]]
then
zenity --info --title "Databases" --text "`ls  Databases`"
else
zenity --warning --title "notice" --text "you have not any Data base"
fi

