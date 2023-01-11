#!/bin/bash

FILE_URL="https://github.com/dollar349/home/archive/refs/tags/v1.tar.gz"
#FILE_URL="https://ghe.int.vertivco.com/ETA/meta-z51/archive/honister-z51-2.20.0.tar.gz"

FILE_NAME=$(echo ${FILE_URL} | awk -F '/' '{print $NF}')

wget ${FILE_URL} 2> /dev/null
if test $? != 0;then
    echo "Cannot get file"
else
    rm ${FILE_NAME}
fi