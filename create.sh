#!/bin/bash

DBname=$(zenity --forms --title "create DB" --text "Database creation \n must not have special char or start with number" --add-entry "Database Name" --width 400 )
if [[ $DBname =~ $rg0 ]] && [[ $DBname != $rg1 ]]
then
if [ -d "Databases" ]
then
if [ -d Databases/"$DBname" ]
then
zenity --error --title "error" --text "error there are the same dB name"
else 
mkdir `pwd`/Databases/"$DBname"
fi
else
mkdir -p `pwd`/Databases/"$DBname"
fi
else 
zenity --error --title "error" --text "incorrect name\nmust not have special char or start with number" 
fi


