#!/bin/bash



if [ $# -eq 1 ] && [ -n "$1" ]; then 
	file_mask=$1
else
	echo "Введите маску"
	read file_mask
fi 


cd ../02/ || { echo "Не удалось перейти в директорию ../02/"; exit 1; }

find . ! -name "*.sh" -type f -name "$file_mask" -exec rm {} \;


find . -depth  -type d  -name "$file_mask" -exec rm -r {} \;

find . -depth -type d -name "$file_mask"  -empty -exec echo Удаляется пустая директория: {} \; -exec rmdir {} \;
echo "Операция удаления завершена."

