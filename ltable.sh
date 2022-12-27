#!/bin/bash
list=$(ls Databases/$DBconnect|sed '/meta*/d')
zenity --info --text "$list"
