#!bin/bash
filename() {
    local input_alphabet=$1
    local name_alphabet=${input_alphabet%%.*}
    local extension_alphabet=${input_alphabet#*.}
    local name_string=""
    local extension_string=""
    local name_length=${#name_alphabet}
    local extension_length=${#extension_alphabet}

    local target_name_length=$((RANDOM % 4 + 4)) # Генерируем число от 4 до 7

    for ((i=0; i < name_length && i < target_name_length; i++)); do
        name_string+=${name_alphabet:$i:1}
    done
    while [ ${#name_string} -lt $target_name_length ]; do
        name_string+=${name_alphabet:$((RANDOM % name_length)):1}
    done

    
    for ((i=0; i < extension_length && i < 3; i++)); do
        extension_string+=${extension_alphabet:$i:1}
    done

    echo "${name_string}_$(date +%d%m%y).${extension_string}"
}

