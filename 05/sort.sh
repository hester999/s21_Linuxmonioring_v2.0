#!/bin/bash

# Путь к файлу с логами
path="../04/log_day_1.log ../04/log_day_2.log ../04/log_day_3.log ../04/log_day_4.log ../04/log_day_5.log"

# Функция 1: Все записи, отсортированные по коду ответа
func_1() {
    awk '{print $9, $0}' ${path} | sort -n | cut -d' ' -f2- >> sorted_log.log
}

# Функция 2: Все уникальные IP, встречающиеся в записях
func_2() {
    awk '{print $1}' ${path} | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n | uniq >> unique_ips_sorted.log
}

# Функция 3: Все запросы с ошибками (код ответа - 4хх или 5хх)
func_3() {
    awk '$9 ~ /^[45][0-9][0-9]$/' ${path} >> errors.log
}

# Функция 4: Все уникальные IP, которые встречаются среди ошибочных запросов
func_4() {
    awk '$9 ~ /^[45][0-9][0-9]$/{print $1}' ${path} | sort -u >> unique_error_ips.log
}

