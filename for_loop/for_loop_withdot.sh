#!/bin/sh

ITEM="HELLO,ast2500,m_ast2500"

LIST=`echo $ITEM | sed 's/,/ /g'`
for i in $LIST
do
    if [[ ${i} =~ ^m_* ]] ; then
       MACHINE=${i:2}
       break
    fi
done

echo ${MACHINE}