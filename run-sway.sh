#!/bin/sh
set -eux
passwd --delete $USER
usermod -a -G wheel --shell /bin/bash --home $HOME $USER
if rmdir /home; then
    ln -s /var/home /home
fi
runuser -u $USER -- bash -exc "
export HOME=$HOME; \
export PATH=$PATH; \
export USER=$USER; \
export LANG=$LANG; \
export BROWSER=firefox-wayland; \
export XDG_CURRENT_DESKTOP=sway; \
export \$(gnome-keyring-daemon --start --components=ssh); \
cd \$HOME; \
exec sway"
