#!bin/bash 



sh ./install.sh 
goaccess -f ../04/*.log  --log-format=COMBINED --time-format=%T -o report.html
xdg-open report.html

goaccess -f ../04/*.log --log-format=COMBINED
