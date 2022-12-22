#!/bin/bash
flag=0
update=$(zenity --forms --title "update" --text "enter values" --add-entry "table name" --add-entry "attribute" --add-entry "value" --add-entry "where attribute" --add-entry "its value" --separator=: )
tablename=$(echo $update|cut -f1 -d:)
att0=$(echo $update|cut -f2 -d:)
value=$(echo $update|cut -f3 -d:)
weratt=$(echo $update|cut -f4 -d:)
wervalue=$(echo $update|cut -f5 -d:)
if [ -f Databases/$DBconnect/"$tablename" ] && [[ $tablename != $rg2 && $tablename != "" ]]
then
att1=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -w "$weratt")
att2=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -nw "$att0"|cut -f1 -d:)
(( att2 ++ ))
if [[ $weratt == $att1 ]]
then
c=$(grep -n "$att0" Databases/$DBconnect/"meta$tablename")
cpk=$(echo $c|cut -f4 -d:)
cn=$(echo $c|cut -f1 -d:)
if [[ $cpk == "Primary_Key" ]]
then
flag=$(awk -v v=$value -v cf=$cn '{if($cf==v)print 1}' Databases/$DBconnect/"meta$tablename")
fi
if [[ $flag == 0 ]]
then
att1=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -nw "$weratt"|cut -f1 -d:)
(( att1++ ))
touch Databases/$DBconnect/temp
awk -F: -v wat=$att1 -v at=$att2 -v v=$value -v wv=$wervalue '{OFS=FS}{if($wat==wv){$at=v;print }else {print $0}}' Databases/$DBconnect/$tablename >> Databases/$DBconnect/temp
cp Databases/$DBconnect/temp Databases/$DBconnect/$tablename
rm Databases/$DBconnect/temp
else
zenity --error --title "error" --text "attribute is PK \nDuplicate value"
fi
else
zenity --error --title "error" --text "attribute not found"
fi
else
zenity --error --title "error" --text "table not found OR invalid values"
fi
