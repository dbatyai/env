#!/bin/sh

set -e

dir=$(readlink -f "$0" | xargs dirname)
pushd "$dir" > /dev/null

temp=$(find /sys/devices/platform/coretemp.0 -name temp1_input)
if [ ! -z "$temp" ]; then
  ln -sf $temp cpu_temp
fi
