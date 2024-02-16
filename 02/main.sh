#!/bin/bash

start_time=$(date +%s)




folder_name=$1
file_name=$2
size=$3

bash folder_create.sh "$folder_name"  "$file_name" "$size"

end_time=$(date +%s)
res=$((end_time - start_time))

start_readable=$(date -d "@$start_time" +" %H:%M:%S")

echo "Script started at: $start_readable"
echo "Script started at: $start_readable" >> log.txt


end_readable=$(date -d "@$end_time" +"%H:%M:%S")

echo "Script ended at: $end_readable"
echo "Script ended at: $end_readable" >> log.txt

echo "Execute time: ${res} sec"
echo "Execute time: ${res} sec" >> log.txt


