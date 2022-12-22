#!/bin/bash
arr3=("All Data" "Specific Data")
delchoice=$(zenity --list  --title "delete"   --text "delete data" --column "" "${arr3[0]}" "${arr3[1]}")
if [[ $delchoice == ${arr3[0]} ]]
then
deltable=$(zenity --entry  --title "delete all data " --text "enter table name ")
if [ -f Databases/$DBconnect/$deltable ]
then
echo > Databases/$DBconnect/$deltable
else
zenity --error --title "error" --text "the table not found"
fi
elif [[ $delchoice == ${arr3[1]} ]]
then
while [[ $delchoice != "exit" ]]
do
delchoice=$(zenity --forms  --title "delete Specific Data" --text "delete data" --add-entry "table name" --add-entry "P.K" --add-entry "P.K value" --cancel-label "" --extra-button "exit" --separator=:)
tbname=$(echo $delchoice|cut -f1 -d:)
pk=$(echo $delchoice|cut -f2 -d:)
pkval=$(echo $delchoice|cut -f3 -d:)
if [[ $delchoice != "" && $delchoice != "exit" ]]
then
if [ -f Databases/$DBconnect/$tbname ]
then
checkPk=$(grep -w -n '$pk' Databases/$DBconnect/"meta$tbname" | cut -f1,4 -d:)
if [[ $checkPk == *"Primary_Key" ]]
then
colNum=$(echo $checkPk|cut -f1 -d:)
touch Databases/$DBconnect/temp
awk -F: -v pkv=$pkval '{if(pkv!=$2)print $0}' Databases/$DBconnect/$tbname > Databases/$DBconnect/temp
rm Databases/$DBconnect/$tbname
mv Databases/$DBconnect/temp Databases/$DBconnect/$tbname
else
zenity --error --title "error" --text "the column is not PK OR not found"
fi
else
zenity --error --title "error" --text "table not found"
fi
fi
done
else
zenity --error --title "error" --text "must enter any choice"
fi
