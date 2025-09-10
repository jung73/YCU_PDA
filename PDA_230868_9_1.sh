
#!/bin/bash

nkf -w -Lu rawdata_pop1980.csv > rawdata_pop1980_utf8.csv

awk 'NR>11' rawdata_pop1980_utf8.csv > rawdata_pop1980_utf8_1.csv

sed 's/"//g' rawdata_pop1980_utf8_1.csv > rawdata_pop1980_utf8_2.csv

awk -F,  '{OFS="," ; print $10, $12, $14}' rawdata_pop1980_utf8_2.csv > rawdata_pop1980_utf8_3.csv

(echo "コード,市区町村,人口" && awk -F,  'NR>1'  rawdata_pop1980_utf8_3.csv) > rawdata_pop1980_utf8_4.csv

head -1 rawdata_pop1980_utf8_4.csv > data.csv

tail -n +2 rawdata_pop1980_utf8_4.csv| grep -v '市部'  | grep -v  '郡部' | grep -v '^[0-9]*000,' | grep -v  '区,' | grep -v '支庁'  >> data.csv 

awk -F, '{sum+=$3;} END{print sum}' data.csv