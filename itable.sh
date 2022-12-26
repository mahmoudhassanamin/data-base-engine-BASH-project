#!/bin/bash
j=1
flag=0
record=""
tableName=$(zenity --entry --title "insert" --text "table name" )
if [ -f Databases/$DBconnect/$tableName ]
then
for i in `cat Databases/$DBconnect/"meta$tableName"`
do
isPK=$(echo $i|cut -f3 -d:)
attName=$(echo $i|cut -f1 -d:)
dtype=$(echo $i|cut -f2 -d:)
entry=$(zenity --entry --text "$attName($isPK)")
 (( j++ ))
if [[ $isPK == "Primary_Key" ]]
then
if [[ $dtype == int ]]
then
if [[ $entry =~ $int ]]
then
if test `cut -f$j -d: Databases/$DBconnect/$tableName|grep -w "$entry"`
then
zenity --error --title "error" --text "there are the same value \nmust be unique value"
flag=1
break
else
record=$record:$entry
fi
else
zenity --error --title "error" --text "must be numbers"
flag=1
break
fi	
else
if test `cut -f$j -d:|grep -w "$entry"`
then
zenity --error --title "error" --text "there are the same value \nmust be unique value"
flag=1
break
else
record=$record:$entry
fi
fi
else
if [[ $dtype == "int" ]]
then
if [[ $entry =~ $int ]]
then
record=$record:$entry
else
zenity --error --title "error" --text "must be numbers"
flag=1
break
fi
else
record=$record:$entry
fi
fi
done
if [[ $flag == 1 ]]
then
zenity --error --title "it is ok" --text "try again"
else
echo $record >> Databases/$DBconnect/$tableName
fi
else
zenity --error --title "error" --text "table not found"
fi
