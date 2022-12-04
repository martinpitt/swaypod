#!/bin/sh
set -ex

# enable manpages
sed -i s/nodocs// /etc/dnf/dnf.conf

dnf -y swap coreutils-single coreutils-full
dnf -y update

dnf -y install \
    glibc-langpack-de glibc-langpack-en \
    bash-completion sudo passwd hostname flatpak-spawn \
    mutt isync w3m weechat duplicity git patchutils make strace syncthing krb5-workstation \
    sway swayidle swaylock kanshi waybar mako slurp grim xorg-x11-server-Xwayland firefox-wayland wofi \
    dejavu-sans-mono-fonts dejavu-sans-fonts dejavu-serif-fonts google-noto-emoji-color-fonts fontawesome-fonts \
    brightnessctl wl-clipboard vim-enhanced \
    pcmanfm pavucontrol nm-connection-editor eog evince gnome-keyring pinentry-gnome3 lxterminal gnome-disk-utility rofimoji \
    ansible man-db man-pages moreutils fd-find ripgrep gh \
    python3-boto python3-boto3 python3-openstacksdk libnotify \
    /usr/bin/scanimage /usr/bin/pngquant /usr/bin/convert \

dnf clean all
