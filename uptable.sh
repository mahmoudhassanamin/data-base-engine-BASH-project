#!/bin/bash
flag=0 
update=$(zenity --forms --title "update" --text "enter values" --add-entry "table name" --add-entry "attribute" --add-entry "value" --add-entry "where attribute" --add-entry "its value" --separator=: )
tablename=$(echo $update|cut -f1 -d:)
att0=$(echo $update|cut -f2 -d:)
value=$(echo $update|cut -f3 -d:)
weratt=$(echo $update|cut -f4 -d:)
wervalue=$(echo $update|cut -f5 -d:)
rg2='^[a-zA-Z0-9"_""@"][a-zA-Z0-9"_""@"]*$'
if [ -f Databases/$DBconnect/"$tablename" ] && [[ $tableName =~ $rg0 ]] && [[ $tableName != $rg1 && $wervalue =~ $rg2 && $value =~ $rg2 ]]
then
att1=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -w "$weratt")
att2=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -nw "$att0"|cut -f1 -d:)
(( att2 ++ ))
if [[ $weratt == $att1 ]]
then
c=$(grep -n "$att0" Databases/$DBconnect/"meta$tablename")
echo $c
cpk=$(echo $c|cut -f4 -d:)
ctype=$(echo $c|cut -f3 -d:)
cn=$(echo $c|cut -f1 -d:)
(( cn++ ))
if [[ $cpk == "Primary_Key" ]]
then
flag=$(awk -F: -v v=$value -v cf=$cn '{if($cf==v)print 1}' Databases/$DBconnect/$tablename)
echo $flag
fi
if [[ $flag != 1 ]]
then
att1=$(cut -f1 -d: Databases/$DBconnect/"meta$tablename"|grep -nw "$weratt"|cut -f1 -d:)
(( att1++ ))
if [[ $ctype == int ]]
then
if [[ $value =~ $int ]]
then
touch Databases/$DBconnect/temp
awk -F: -v wat=$att1 -v at=$att2 -v v=$value -v wv=$wervalue '{OFS=FS}{if($wat==wv){$at=v;print $0 }else {print $0}}' Databases/$DBconnect/$tablename >> Databases/$DBconnect/temp
cp Databases/$DBconnect/temp Databases/$DBconnect/$tablename
rm Databases/$DBconnect/temp
else
zenity --error --title "error" --text "attribute value must be number"
fi
else
touch Databases/$DBconnect/temp
awk -F: -v wat=$att1 -v at=$att2 -v v=$value -v wv=$wervalue '{OFS=FS}{if($wat==wv){$at=v;print $0 }else {print $0}}' Databases/$DBconnect/$tablename >> Databases/$DBconnect/temp
cp Databases/$DBconnect/temp Databases/$DBconnect/$tablename
rm Databases/$DBconnect/temp
fi
else
zenity --error --title "error" --text "attribute is PK \nDuplicate value"
fi
else
zenity --error --title "error" --text "attribute not found"
fi
else
zenity --error --title "error" --text "table not found OR invalid values"
fi
