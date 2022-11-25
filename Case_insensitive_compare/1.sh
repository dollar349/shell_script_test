#!/bin/bash

CompareStr="Dollar"
InputStr="dollar"

# Show Upper Case
echo "CompareStr = ${CompareStr^^}"

# Show lower case
echo "CompareStr = ${CompareStr,,}"

if test "${CompareStr^^}" = "${InputStr^^}" ;then
   echo "the same string"
fi
