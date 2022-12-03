# Experiment: Run sway desktop in Container

I have maintained a [custom minimal Sway OSTree repo](https://piware.de/post/2020-12-13-ostree-sway/)
for quite some time. This works well, but needs some custom infrastructure to
publish the OSTree, and maintaining the project is not as easy as it could be.
So I am exploring some possible alternative structures. One is
[ostree native containers](https://coreos.github.io/rpm-ostree/container/),
but it would be so much cooler to rather do this:

 1. Install a standard [Fedora IoT OStree](https://getfedora.org/iot/), and
    leave OS maintenance to the people who are really good at it.

 2. Overlay a few packages which are required on a laptop; this is mostly
    Wifi/sound firmware and possibly OpenVPN and such.

 3. Deliver as much as possible in a container image, in particular the desktop
    (sway, fonts, apps, etc.).

That would have the following advantages to my current approach:

 - It would make running the desktop/workstation largely independent from the
   base OS. User podman containers work on current Fedora, CoreOS, CentOS,
   RHEL, Debian, Ubuntu, Arch. etc.

 - Building, delivering, and updating the desktop could use the
   excellent tools and infrastructure which is available for OCI containers.

 - The user can run `sudo dnf install` etc. normally, without having to think
   about "Oh, I need to switch into that toolbox for some tasks". `sudo` is
   even passwordless, as it does not *really* have any more privileges: E.g.
   `sudo cat /dev/sda` still fails with "permission denied", as it's only root
   inside the user's swaypod container.

## Running

Boot your machine normally, but log into a VT. Stop any graphical login
managers.

    podman container runlabel INSTALL ghcr.io/martinpitt/swaypod
    podman start swaypod

## Building

Build locally with:

    podman build -t ghcr.io/martinpitt/swaypod .

(or choose any other label, of course). The image is also auto-built in
the [build workflow](.github/workflows/build.yaml) and published as container
artifact on GitHub's internal registry. This does not need any particular setup
for secrets, so it will Just Work™ on any fork.

## Caveats

This works surpisingly well already. The [#1 issue](https://github.com/martinpitt/swaypod/issues/1)
is that it does not receive any hardware change updates (in particular, kernel
uevents), so docking/undocking, inserting a Yubikey, etc. does not work. This
may well not work at all with current Linux -- if not, then this project is a
failed experiment.

The `INSTALL` step currently also only works once, see
[issue #2](https://github.com/martinpitt/swaypod/issues/2). This is a solvable
bug, though, and has a workaround.

The images cannot get too large, due to a podman/Linux/filesystem restriction,
see [podman#16541](https://github.com/containers/podman/issues/16541).
