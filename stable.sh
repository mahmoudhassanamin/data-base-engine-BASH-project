#!/bin/bash
arr4=("select all data" "select specific data")
select=$(zenity --list --title "select" --text "choose a query" --column "" "${arr4[0]}" "${arr4[1]}" )
if [[ $select == ${arr4[0]} ]]
then
table=$(zenity --entry --title "select" --text "enter table name")
if [ -f Databases/$DBconnect/$table ]
then
x=$(cut -f1 -d:  Databases/$DBconnect/"meta$table"|awk '{print "--column "$0}')
#for i in Databases/$DBconnect/$table
#do
#done
zenity --list --title "$table" $x
else
zenity --error --title "error" --text "table not found"
fi
elif [[ $select == ${arr4[1]} ]]
then
echo x
else
. warning.sh
fi
