#!/bin/bash
arr4=("select all data" "select specific data")
select=$(zenity --list --title "select" --text "choose a query" --column "" "${arr4[0]}" "${arr4[1]}" )
if [[ $select == ${arr4[0]} ]]
then
table=$(zenity --entry --title "select" --text "enter table name")
if [ -f Databases/$DBconnect/"$table" ] && [[ $table =~ $rg0 ]] && [[ $table != $rg1 ]]
then
zenity --text-info --title "$table" --filename=Databases/$DBconnect/"$table"
else
zenity --error --title "error" --text "table not found"
fi
elif [[ $select == ${arr4[1]} ]]
then
table=$(zenity --forms --title "select" --text "enter values" --add-entry "table name" --add-entry "attribute name" --add-entry "attribute value" --separator=:)
tname=$(echo $table|cut -f1 -d:)
attname=$(echo $table|cut -f2 -d:)
attvalue=$(echo $table|cut -f3 -d:)
rg2='^[a-zA-Z0-9"_""@"][a-zA-Z0-9"_""@"]*$'
if [ -f Databases/$DBconnect/"$tname" ] && [[ $tname =~ $rg0 ]] && [[ $tname != $rg1 && $attname =~ $rg0 && $attname != $rg1 ]] && [[ $attvalue =~ $rg2 ]]
then

if test `cut -f1 -d: Databases/$DBconnect/meta$tname|grep -w "$attname"`
then
touch Databases/$DBconnect/temp
column=$(cut -f1 -d: Databases/$DBconnect/meta$tname|grep -nw "$attname"|cut -f1 -d:)
(( column++ ))
awk -F: -v value="$attvalue" -v field=$column '{if(value==$field)print $0}' Databases/$DBconnect/$tname >> Databases/$DBconnect/temp
zenity --text-info --title "$tname" --filename=Databases/$DBconnect/temp
rm Databases/$DBconnect/temp
else
zenity --error --title "error" --text "attribute not exist"
fi
else
zenity --error --title "error" --text "table not found"
fi
else
. warning.sh
fi
