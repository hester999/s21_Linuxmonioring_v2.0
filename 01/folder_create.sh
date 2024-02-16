#!/bin/bash

source filename_generator.sh



name_gen() {
    local alphabet=$1
    local alphabet_length=${#alphabet}
    local string=""
    # Генерация целевой длины строки от 4 до 7 символов
    local target_length=$(($RANDOM % 4 + 4))

    local min_length=$((alphabet_length < target_length ? alphabet_length : target_length))
    for ((i=0; i < min_length; i++)); do
        string+=${alphabet:$i:1}
    done

    while [ ${#string} -lt $target_length ]; do
        local random_char=${alphabet:$((RANDOM % alphabet_length)):1}
        string+="$random_char"
    done

    string+="_$(date +%d%m%y)"
    echo "$string"
}


check_free_space() {
    local path=$1
    local free_space_gb=$(df "$path" | awk 'NR==2 {print $4}' | awk '{print $1/1024/1024}')

    if [[ -n "$free_space_gb" ]] && [[ "$free_space_gb" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    compare_result=$(printf "%.0f\n" "$free_space_gb" | bc -l)
    	if [[ $compare_result -lt 1 ]]; then
        echo "Error: There is less than 1 GB of free space left in the file system for the $path partition"
	exit 1
    	fi
   fi
}





generate_folder() {
    local folder_count=$1
    local alphabet=$2
    local size=$(echo "$size_with_kb" | grep -o '[0-9]*')
    i=1
    while [ $i -le $folder_count ]; do
        check_free_space "$path"
       # local folder_name=$(generate_string "$alphabet")
         local folder_name=$(name_gen "$alphabet")
	 while [[ -d $folder_name ]]; do
            # folder_name=$(generate_string "$alphabet")
            folder_name=$(name_gen "$alphabet")
        done

        echo "folder create: $folder_name $(date '+%d-%m-%Y %H:%M:%S')" >> log.txt
        mkdir "$folder_name"
        i=$((i + 1))
	
	 for ((j=1; j <= file_count; j++)); do
           # file_name=$(generate_filename "$filename")
             file_name=$(filename "$filename")
            fallocate -l "${size}K"  "$path/$folder_name/$file_name"
	    echo "file create: $file_name in folder $folder_name $(date '+%d-%m-%Y %H:%M:%S') size:$(ls -lh "${folder_name}/${file_name}" | awk '{print $5}')" >> log.txt
	
        done
	
    done
}


path=$1
cd $path 
echo "PATH: $path">>log.txt
folder_count=$2
alphabet=$3
file_count=$4
filename=$5
size_with_kb=$6
generate_folder $folder_count "$alphabet"

