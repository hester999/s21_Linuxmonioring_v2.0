#!/bin/bash

source filename_generator.sh

name_gen() {
    local alphabet=$1
    local alphabet_length=${#alphabet}
    local string=""
    local target_length=$(($RANDOM % 3+5))

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
    # Получаем свободное место для корневого пути в человекочитаемом формате (гигабайты, мегабайты и т.д.)
    local free_space=$(df -h / | awk 'NR==2 {print $(NF-2)}')

    # Логирование текущего свободного места для отладки
  

    # Извлекаем число и единицу измерения (G, M)
    local free_space_value=$(echo $free_space | sed -e 's/[A-Za-z]//g')
    local free_space_unit=$(echo $free_space | sed -e 's/[0-9.]//g')

    # Если единица измерения - гигабайты (G) и свободное место меньше 1, прекращаем выполнение
    if [[ "$free_space_unit" == "G" ]] && (( $(echo "$free_space_value < 1" | bc -l) )); then
        echo "Error: Less than 1 GB of free space on root partition."
        exit 3
    # Если единица измерения - мегабайты (M) или килобайты (K), прекращаем выполнение
    elif [[ "$free_space_unit" == "M" ]] || [[ "$free_space_unit" == "K" ]]; then
        echo "Error: Critically low free space on root partition."
        exit 3
    fi
}






generate_folder() {
    local folder_count=100
    local alphabet=$1
    local size=$(echo "$size_with_mb" | grep -o '[0-9]*')
    cd $path
    i=1
    while [ $i -le $folder_count ]; do
        check_free_space 
        local folder_name=$(name_gen "$alphabet")

	 while [[ -d $folder_name ]]; do
	   check_free_space 	
	    echo "$folder_name уже существует"           
            folder_name=$(name_gen "$alphabet")
        done

        echo "folder create: $folder_name $(date '+%d-%m-%Y %H:%M:%S')" >> log.txt
        mkdir "$folder_name"
        i=$((i + 1))
	
	 local file_count=$((RANDOM % 1000 + 1))
         
	 for ((j=1; j <= file_count; j++)); do
	    check_free_space	
            file_name=$(filename "$filename")
            fallocate -l "${size}M"  "$folder_name/$file_name"
	    echo "file create: $file_name in folder $folder_name $(date '+%d-%m-%Y %H:%M:%S') size:$(ls -lh "${folder_name}/${file_name}" | awk '{print $5}')" >> log.txt
	
        done
	
    done
}

path=$(pwd)
alphabet=$1
filename=$2
size_with_mb=$3

generate_folder  "$alphabet"


