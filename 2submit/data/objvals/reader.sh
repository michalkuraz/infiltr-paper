#!/bin/bash



filename="ll"
while read -r line
do
    name="$line"
    echo "Name read from file - $name"
done < "$filename"