#!/bin/bash
arr2=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "exit")
while [[ $choice != ${arr2[7]} ]]
do
choice=$(zenity --list --title "DB $DBconnect" --text "Welcome" --column "MyEgle" "${arr2[0]}" "${arr2[1]}" "${arr2[2]}" "${arr2[3]}" "${arr2[4]}" "${arr2[5]}" "${arr2[6]}" "${arr2[7]}" --width 300 --height 320 --cancel-label "")
if [[ $choice == ${arr2[0]} ]]
then
. ctable.sh
elif [[ $choice == ${arr2[1]} ]]
then
. ltable.sh	
elif [[ $choice == ${arr2[2]} ]]
then
. dtable.sh
elif [[ $choice == ${arr2[3]} ]]
then
. itable.sh	
elif [[ $choice == ${arr2[4]} ]]
then
. stable.sh
elif [[ $choice == ${arr2[5]} ]]
then
. deltable.sh
elif [[ $choice == ${arr2[6]} ]]
then
. uptable.sh
elif [[ $choice != ${arr2[7]} ]]
then
. warning.sh
fi
done
