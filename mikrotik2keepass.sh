#!/bin/bash
#
# mikrotik2keepas
#
# Script for exporting DHCP Leases from Mikrotik into Generic CSV format fit for importing to Keepass2
#
# Usage:
#     mikrotik2keepass.sh [user@]hostname [vnc-password] [notes] > file.csv
#

ADDRESS="$1"
OUTPUT=`ssh $ADDRESS /ip dhcp-server lease print terse`

formated_output (){
    echo "$OUTPUT" | while read -r line ; do
        echo -n ' "'
        # ID
        echo $line | grep -oP '^[0-9]+' | tr -d '\n'
        echo -n '" "'
        # Comment
        echo $line | grep -oP '(?<=comment=)[^(\s|\n)]*' | tr -d '\n'
        echo -n '" "'
        # Address
        echo $line | grep -oP '(?<=[^mac-]address=)[^(\s|\n)]*' | tr -d '\n'
        echo -n '" "'
        # Active Hostname
        echo $line | grep -oP '(?<=host-name=)[^(\s|\n)]*' | tr -d '\n'
        echo -n '"'
    done
}

SELECTED="$(eval 'zenity --list --multiple --width 1000 --height 800 --column="ID" --column="Comment" --column="Address" --column="Active Hostname" '`formated_output`)"

echo "$OUTPUT" | while read -r line ; do
    if $(echo $line | grep -P -q '^('$SELECTED') ') ; then
        echo -n ' "'
        # Title
        echo $line | grep -oP '(?<=comment=)[^(\s|\n)]*' | tr -d '\n'
        echo -n '","'
        # Username
        echo $line | grep -oP '(?<=host-name=)[^(\s|\n)]*' | tr -d '\n'
        echo -n '","'
        # Password
        echo -n "$2"
        echo -n '","'
        # URL
        echo -n 'vnc://'
        echo $line | grep -oP '(?<=[^mac-]address=)[^(\s|\n)]*' | tr -d '\n'
        echo -n '","'
        # Notes
        echo -n "$3"
        echo '"'
    fi
done
