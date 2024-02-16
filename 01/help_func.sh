generate_filename() { # заменить в файле генеерации имен файлов
    
    local input_alphabet=$1
    local name_alphabet=${input_alphabet%%.*}
    local extension_alphabet=${input_alphabet#*.}
    local name_string=""
    local extension_string=""
    local name_length=${#name_alphabet}
    local extension_length=${#extension_alphabet}
    local used_length=0
    local remaining_length_name=7
    local remaining_length_extension=3

   
    for ((i=0; i < name_length; i++)); do
        local char=${name_alphabet:$i:1}
        local add
        if [ $i -eq 0 ]; then
            add=$((RANDOM % (7 - name_length + 1) + 1))
        else
            local max_possible=$((7 - used_length - (name_length - i - 1)))
            add=$((RANDOM % max_possible + 1))
        fi
        for ((j=0; j < add; j++)); do
            name_string+="$char"
            let used_length++
            if [ $used_length -ge 7 ]; then
                break 2
            fi
        done
    done

    used_length=0  # Сброс для расширения
    
    for ((i=0; i < extension_length && i < remaining_length_extension; i++)); do
        local char=${extension_alphabet:$i:1}
        extension_string+="$char"
        let used_length++
    done

    
    local final_string="${name_string}_$(date +%d%m%y).${extension_string}"
    echo "$final_string"
}










generate_string() { #заменить в файле генерации папок 
    local alphabet=$1
    local alphabet_length=${#alphabet}
    local string=""
    local remaining_length=7
    local used_length=0

    for ((i=0; i < alphabet_length; i++)); do
        local char=${alphabet:$i:1}
        local add

        
        if [ $i -eq 0 ]; then
            add=$((RANDOM % (7 - alphabet_length + 1) + 1))
        else
            local max_possible=$((7 - used_length - (alphabet_length - i - 1)))
            add=$((RANDOM % max_possible + 1))
        fi

        for ((j=0; j < add; j++)); do
            string+="$char"
            let used_length++
        done

       
        if [ $used_length -ge 7 ]; then
            break
        fi
    done

    string+="_$(date +%d%m%y)"
    echo "$string"

}
