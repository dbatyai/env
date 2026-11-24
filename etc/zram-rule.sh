#! /bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

echo -n "zram disk size [16G]: "
read size || exit 1
size=${size:-16G}

echo "KERNEL==\"zram0\", ATTR{disksize}=\"$size\" RUN=\"/usr/sbin/mkswap /dev/zram0\", TAG+=\"systemd\"" > $1
