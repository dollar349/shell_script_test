#!/bin/sh
Table="
dollar:tap1
ritzen:tap2
"

for i in ${Table}
do
  name=`echo $i | awk -F':' '{print $1}'`
  tap=`echo $i | awk -F':' '{print $2}'`
  echo $name $tap
done
