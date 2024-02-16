#!bin/bash


path=../02/


cd $path

name=$(awk '/folder create:/ {print $3}' log.txt)

for i in $name; do 
	rm -rf "$i"
done

echo "All folders and files have been deleted"
