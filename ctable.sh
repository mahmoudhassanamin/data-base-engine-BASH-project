#!/bin/bash
entry=$(zenity --forms --title "Creat Table" --text "new" --add-entry="enter table name" --add-entry="number of attributes" --separator=:)
tname=$(echo $entry | awk -F: '{print $1}')
natt=$(echo $entry | awk -F: '{print $2}')
flag=0
flag2=0
if [[ $tname == $rg0 || $tname == $rg2 || $tname == $rg3 || $tname == $rg4 ]] && [[ $natt != *0* ]] && [[ $natt =~ $int ]] && [[ $tname != $rg1 && $tname != $rg5 ]]
then
if [ ! -f Databases/$DBconnect/$tname ]
then
touch Databases/$DBconnect/$tname Databases/$DBconnect/"meta$tname"
for (( i=1; i<=$natt; i++ ))
do
att=$(zenity --forms --title "Creat Table" --text "insert attribute $i" --add-entry="attribute name" --add-combo "Data type" --combo-values "int|string" --add-combo "constraint" --combo-values "Primary_Key|""" --ok-label="done" --separator=:)
if [[ $att != "" ]]
then
attname=$(echo $att|cut -f1 -d:)
atttype=$(echo $att|cut -f2 -d:)
if [[ $attname == $rg0 || $attname == $rg2 || $attname == $rg3 || $attname == $rg4 ]] && [[ $attname != $rg1 && $attname != $rg5 && $atttype != " " ]]
then
if test `cut -f1 -d: Databases/$DBconnect/"meta$tname"|grep -w $attname`
then
zenity --error --title "error" --text "there are the same attribute name"
(( i-- ))
flag=0
else
if [[ $flag2 == 1 && `echo $att |cut -f3 -d:` == "Primary_Key" ]]
then
zenity --error --title "error" --text "must be one pk for every table"
(( i-- ))
else
if [[ `echo $att |cut -f3 -d:` == "Primary_Key" ]]
then
flag2=1
fi
echo $att >> Databases/$DBconnect/"meta$tname"
fi
fi
else
zenity --error --title "error" --text "invald value"
(( i-- ))
fi
else
rm Databases/$DBconnect/$tname Databases/$DBconnect/"meta$tname"
i=$natt
fi
done
defualt_pk=$( cut -f3 -d: Databases/$DBconnect/"meta$tname" )
if [[ $defualt_pk == "" ]] 
then 
touch Databases/$DBconnect/temp 
awk -F: '{OFS=FS}{if (NR==1) {$3="Primary_Key" ; print $0 } else {print $0} }' Databases/$DBconnect/"meta$tname" > Databases/$DBconnect/temp
cp Databases/$DBconnect/temp Databases/$DBconnect/"meta$tname"
rm Databases/$DBconnect/temp
fi 
else
zenity --error --title "error" --text "there are table as tha same name"
fi
else
zenity --error --title "error" --text "please \nenter valid name and at lest one att"
fi

