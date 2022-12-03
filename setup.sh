#!/bin/sh
set -ex

# commands to forward to the host
for cmd in podman toolbox nmcli; do
    printf "flatpak-spawn --host $cmd \42\$@\42\n" > /usr/local/bin/$cmd
    chmod a+x /usr/local/bin/$cmd
done
