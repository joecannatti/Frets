while read p; do ./ultimate_guitar.rb $(echo $p | awk -F, '{print $1}') $(echo $p | awk -F, '{print $2}'); done < list.csv
