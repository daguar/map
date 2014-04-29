#!/bin/bash
# this is pretty slow and inefficient
while read line
do
    IFS=', ' read -a split <<< "$line"
    echo "${split[1]},${split[0]}"
done < $1
