#!/bin/sh 
set -xe

register_binfmt() {
  mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc && test -f /proc/sys/fs/binfmt_misc/qemu-aarch64 && echo "binfmt already registered" >&2 || \
  printf ":qemu-aarch64:M:0:\x7f\x45\x4c\x46\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xb7:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:%s:C" "$(which qemu-aarch64-static)" > /proc/sys/fs/binfmt_misc/register
}


# Register binfmt for other archs
uname -m | grep aarch64 || register_binfmt

env PATH=/root/.local/bin:/root/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin bash ./build.sh
