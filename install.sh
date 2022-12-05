#!/bin/sh
set -ex

# enable manpages
sed -i s/nodocs// /etc/dnf/dnf.conf

dnf -y swap coreutils-single coreutils-full
dnf -y update

# basic system/shell tools
dnf -y install \
    glibc-langpack-de glibc-langpack-en \
    bash-completion sudo passwd hostname flatpak-spawn git patchutils make strace \
    krb5-workstation \
    man-db man-pages moreutils fd-find ripgrep gh \

# desktop
dnf -y install \
    sway swayidle swaylock kanshi waybar mako slurp grim wofi \
    xorg-x11-server-Xwayland \
    dejavu-sans-mono-fonts dejavu-sans-fonts dejavu-serif-fonts google-noto-emoji-color-fonts fontawesome-fonts \
    brightnessctl wl-clipboard libnotify \
    pcmanfm pavucontrol nm-connection-editor gnome-keyring pinentry-gnome3 lxterminal gnome-disk-utility rofimoji \

# applications
dnf -y install \
    mutt isync w3m \
    weechat \
    duplicity \
    syncthing \
    vim-enhanced \
    firefox-wayland \
    ansible python3-boto python3-boto3 python3-openstacksdk \
    eog \
    evince \
    /usr/bin/scanimage /usr/bin/pngquant /usr/bin/convert \

dnf clean all
