#!/bin/sh
set -ex

# run podman in toolbox
printf "flatpak-spawn --host podman \42\$@\42\n" > /usr/local/bin/podman
printf "flatpak-spawn --host toolbox \42\$@\42\n" > /usr/local/bin/toolbox
chmod a+x /usr/local/bin/podman /usr/local/bin/toolbox
