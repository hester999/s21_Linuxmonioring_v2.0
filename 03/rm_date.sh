#!/bin/bash

    # Аргументы переданы через командную строку
if [ $# -eq 4 ] && [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ]; then    
    start_input="$1 $2"
    end_input="$3 $4"
else
    echo "Введите дату и время начала в формате 'YYYY-MM-DD HH:MM':"
    read start_input
    echo "Введите дату и время окончания в формате 'YYYY-MM-DD HH:MM':"
    read end_input
fi

if ! start_epoch=$(date -d "$start_input" +%s 2>/dev/null); then
    echo "Введены некорректные даты и время начала."
    exit 1
fi

if ! end_epoch=$(date -d "$end_input" +%s 2>/dev/null); then
    echo "Введены некорректные даты и время окончания."
    exit 1
fi

# Переход в директорию ../02/
cd ../02/ || { echo "Не удалось перейти в директорию ../02/"; exit 1; }

echo "Поиск и удаление файлов в директории $(pwd), изменённых с $start_input по $end_input."
find . ! -name "*.sh" -type f -newermt "$start_input" ! -newermt "$end_input" -exec echo Удаляется файл: {} \; -exec rm {} \;

find . -depth -type d -empty -exec echo Удаляется пустая директория: {} \; -exec rmdir {} \;

