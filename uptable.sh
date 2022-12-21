#!/bin/bash
update=$(zenity --forms --title "update" --text "enter values" --add-entry "table name" --add-entry "attribute" --add-entry "value" --add-entry "where attribute" --add-entry "its value")
tablename=$(echo update|cut -f1 -d|)
att0=$(echo update|cut -f2 -d|)
value=$(echo update|cut -f3 -d|)
weratt=$(echo update|cut -f4 -d|)
wervalue=$(echo update|cut -f5 -d|)
if [ -f Databases/$DBconnect/"$tablename" ] && [[ $tablename != $rg2 && $tablename != "" ]]
then
att1=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -w "$att0")
if [ $]
then

else
zenity --error --title "error" --text "attribute not found"
fi
else
zenity --error --title "error" --text "table not found"
fi

