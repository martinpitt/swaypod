FROM registry.fedoraproject.org/fedora:latest

ADD install.sh dummy-deps*.rpm /
RUN /install.sh && rm /install.sh /*.rpm

ADD setup.sh /
RUN /setup.sh && rm /setup.sh

ADD run-sway.sh /usr/local/bin/

CMD ["/usr/local/bin/run-sway.sh"]

LABEL INSTALL="podman create --replace --name swaypod --privileged --user root:root \
    --env-host --ipc=host --network=host --pid=host --ulimit=host --userns=keep-id \
    --no-hosts --dns=none --tz=local \
    --mount type=devpts,destination=/dev/pts \
    -v /dev:/dev:rslave \
    -v /var/home:/var/home:rslave \
    -v /run/dbus:/run/dbus:rslave \
    -v /run/media:/run/media:rslave \
    -v /run/user:/run/user:rslave \
    -v /run/systemd:/run/systemd:rslave \
    -v /run/udev:/run/udev:rslave \
    IMAGE"
