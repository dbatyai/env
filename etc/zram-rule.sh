#! /bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

echo -n "zram disk size: "
read size || exit 1

echo "KERNEL==\"zram0\", ATTR{disksize}=\"$size\" RUN=\"/usr/bin/mkswap /dev/zram0\", TAG+=\"systemd\"" > $1
