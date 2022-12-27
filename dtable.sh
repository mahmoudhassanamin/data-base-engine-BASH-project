#!/bin/bash
drop=$(zenity --entry  --title "drop table "   --text "enter table name " )
if  [ -f Databases/$DBconnect/"$drop" ] && [[ $drop =~ $rg0 ]] && [[ $drop != $rg1 ]]
then
rm  Databases/$DBconnect/$drop Databases/$DBconnect/meta$drop
else
zenity --error --title "error" --text "the table not found "
fi