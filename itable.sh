#!/bin/bash
j=1
flag=0
record=""
entry=1
rg2='^[a-zA-Z0-9"_"][a-zA-Z0-9"_"]*$'
tableName=$(zenity --entry --title "insert" --text "table name" )
if [ -f Databases/$DBconnect/"$tableName" ] && [[ $tableName =~ $rg0 ]] && [[ $tableName != $rg1 ]]
then
for i in `cat Databases/$DBconnect/"meta$tableName"`
do
if [[ $entry != "" ]]
then
isPK=$(echo $i|cut -f3 -d:)
attName=$(echo $i|cut -f1 -d:)
dtype=$(echo $i|cut -f2 -d:)
entry=$(zenity --entry --text "$attName($isPK)($attName)")
 (( j++ ))
if [[ $isPK == "Primary_Key" ]]
then
if [[ $dtype == int ]]
then
if [[ $entry =~ $int && (( $entry > 0 )) ]]
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
if test `cut -f$j -d: Databases/$DBconnect/$tableName|grep -w "$entry"`
then
zenity --error --title "error" --text "there are the same value \nmust be unique value"
flag=1
break
else
if [[ $entry =~ $rg2 ]]
then
record=$record:$entry
else
zenity --error --title "error" --text "invalid value"
flag=1
break
fi
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
if [[ $entry =~ $rg2 || $entry == "" ]]
then
record=$record:$entry
else
zenity --error --title "error" --text "invalid value"
flag=1
break
fi
fi
fi
elif [[ $entry == "" ]]
then
flag=1
zenity --error --title "error" --text "invalid value"
fi
done
if [[ $flag == 1 ]]
then
zenity --error --title "it is ok" --text "try again"
record=""
else
echo $record >> Databases/$DBconnect/$tableName
fi
else
zenity --error --title "error" --text "table not found"
fi
