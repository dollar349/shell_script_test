#!/bin/sh
ABSPATH=$(readlink -f "$BASH_SOURCE")
SCRIPTPATH=$(dirname "$ABSPATH")

cd ~ && MYPATH=`pwd` && cd - > /dev/null
ADD_PATH=`echo $SCRIPTPATH | sed  "s,"${MYPATH}",~,g"`

echo PATH=\${PATH}:$ADD_PATH