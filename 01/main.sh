#!bin/bash

if [ "$#" -ne 6 ]; then
    echo "Enter 6 arguments"
    exit 1
fi

is_number() {
    if ! [[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: argument is not num."
        exit 1
    fi
}

is_number "$2"
is_number "$4"

size_with_kb=$6
temp=$(echo "$size_with_kb" | cut -d'k' -f1)
if  ((temp > 100)); then
	echo "Error: size must be lower or equal 100"
        exit 2 
fi 

path=$1

folder_count=$2


alphabet=$3
file_count=$4
file_name=$5
size=$6

bash folder_create.sh "$path" "$folder_count" "$alphabet" "$file_count" "$file_name" "$size"

