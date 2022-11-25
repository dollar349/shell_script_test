#!/bin/bash

CI_MERGE_REQUEST_LABELS="SkipPRB,ast2600evb"

# Method 1
if test "${CI_MERGE_REQUEST_LABELS#*SkipPRB}" != "${CI_MERGE_REQUEST_LABELS}" ; then
   echo "Skip Merge request build"
fi

# Method 2
if [[ "$CI_MERGE_REQUEST_LABELS" =~ "SkipPRB" ]]; then
   echo "Skip Merge request build"3
fi
