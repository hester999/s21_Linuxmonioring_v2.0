#!/bin/bash

_HELP () {
  echo -e "# HELP ${1}"
}

_TYPE () {
  echo -e "# TYPE ${1}"
}

_PARAM () {
  echo -e "${1} ${2}"
}

get_info_cpu () {
  local cpu_usage
  cpu_usage=$( LC_ALL=C mpstat 1 1 | awk '/Average:/ {print 100 - $NF}')
  readonly cpu_usage

  _HELP "cpu_usage CPU usage."
  _TYPE "cpu_usage gauge"
  _PARAM "cpu_usage" "${cpu_usage}"
}
get_info_ram_free () {
  local ram_free
  ram_free=$( LC_ALL=C  free | awk '/Mem:/ {print $7}')
  readonly ram_free

  _HELP "mem_free Memory free"
  _TYPE "mem_free gauge"
  _PARAM "mem_free" ${ram_free}
}

get_info_disk_available () {
  local disk_available
  disk_available=$( df / | tail -n1 | awk '{print $4}' )
  readonly disk_available

  _HELP "disk_available Available disk"
  _TYPE "disk_available gauge"
  _PARAM "disk_available" ${disk_available}
}

get_info () {
  get_info_cpu > index.html
  get_info_ram_free >> index.html
  get_info_disk_available >> index.html
}
