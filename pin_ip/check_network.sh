#!/bin/bash
if ping -q -c 1 -W 1 10.162.243.220 >/dev/null; then
  echo "The network is up"
else
  echo "The network is down"
fi
