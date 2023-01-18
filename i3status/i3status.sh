#!/bin/sh

set -e

dir=/tmp/i3status
mkdir -p $dir
pushd "$dir" > /dev/null

temp=$(find /sys/devices/platform/coretemp.0 -name 'temp*_input' | sort | head -1)
if [ ! -z "$temp" ]; then
  ln -sf $temp cpu_temp
fi

battery=$(find /sys/class/power_supply/ -name 'BAT*' | sort | head -1)
if [ ! -z "$battery" ]; then
  ln -sf "$battery/uevent" battery
fi
