#!bin/bash

if [ "$#" -lt  1 ]; then
  echo "Error: few arguments"
  exit 1
fi

if ! [[ "$1" =~ ^-?[0-9]+$ ]]; then
    echo "Error: the argument must be a number"
fi

res=$1
start_date=$2
start_time=$3
end_date=$4
end_time=$5
mask=$2
case $res in 
  1)
  bash rm_log.sh
  ;;
  2)
  bash rm_date.sh "$start_date" "$start_time" "$end_date" "$end_time"
  ;;
  3)
  bash rm_mask.sh "$mask"
  ;;

esac
