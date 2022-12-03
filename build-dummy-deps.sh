#!/bin/sh
# generate stub rpm for dependencies which must be on the host
# this saves some space and avoids putting system services into the container

set -eux

cat <<EOF > /tmp/spec
Name: dummy-deps
Summary: dummy dependencies
Version: 999
Release: 1%{?dist}
Provides: device-mapper
Provides: dbus
Provides: dbus-broker
Provides: grubby
Provides: kmod
Provides: podman
Provides: polkit
Provides: systemd-networkd
Provides: systemd-pam
Provides: systemd-resolved
Provides: systemd-udev
Provides: toolbox
Provides: udisks2
Provides: upower
# not a system dep, but eww, no
Provides: tracker
License: BSD

%description
Dummy dependencies to avoid bloat.

%files
EOF

rpmbuild --define "_topdir /tmp/rpmbuild-dummy" -bb /tmp/spec
mv /tmp/rpmbuild-dummy/RPMS/*/dummy-deps-*.rpm .
rm -rf /tmp/rpmbuild-dummy /tmp/spec
