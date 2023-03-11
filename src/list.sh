#!/bin/bash

data="database.txt"
to_filter="list.txt"

rm $data
rm $to_filter

flatpak search $1 >> "$to_filter"
flatpak search $1 | sed 's/\t.*//g' | awk '{ print length, $0 }' | sort -r -n | cut -d" " -f2- >> "$data"

while read line; do
        echo "$line"
        sed -i "s/$line//g" "$to_filter"
        cat "$to_filter"
        sleep 1
done < $data