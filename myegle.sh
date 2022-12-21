#!/bin/bash
shopt -s extglob
LC_COLLATE=C
where=`pwd`
cd $where
rg0='*\*'
rg1='[0-9]*'
rg2='*[\!@|#$%^&*()-+=\["\}\{\]/?><:;\.,`~ ]*'
int='^[0-9][0-9]*$'
arr=("create Database"  "connect Database" "list Databases" "Drop Database" "Exit")

while [[ $choice != ${arr[4]} ]]
do
choice=$(zenity --list --title "MyEgle" --text "what you want?" --width 300 --height 250 --column "Menu" "create Database"  "connect Database" "list Databases" "Drop Database" "Exit" --cancel-label "" )

if [[ $choice == ${arr[0]} ]]
then
. create.sh
elif [[ $choice == ${arr[1]} ]]
then
. connect.sh
elif [[ $choice == ${arr[2]} ]]
then
. list.sh
elif [[ $choice == ${arr[3]} ]]
then
. drop.sh
elif [[ $choice == "" ]] 
then
. warning.sh
fi
done
