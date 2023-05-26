# Wrapper for helipad

This project wraps [Helipad](https://github.com/Podcastindex-org/helipad) for StartOS. Helipad shows boosts and boostagram messages coming in to your Lightning node from your listeners who are using Podcasting 2.0 apps.

## Dependencies

- [docker](https://docs.docker.com/get-docker)
- [docker-buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [yq](https://mikefarah.gitbook.io/yq)
- [appmgr](https://github.com/Start9Labs/embassy-os/tree/master/appmgr)
- [make](https://www.gnu.org/software/make/)

## Cloning

Clone the project locally. Note the submodule link to the original project(s). 

```
git clone git@github.com:ericpp/helipad-startos.git
cd helipad-startos
git submodule update --init

```

## Building

To build the project, run the following commands:

```
make
```

## Installing (on StartOS)

SSH into an Embassy device.
`scp` the `.s9pk` to any directory from your local machine.
Run the following command to determine successful install:

```
appmgr install helipad.s9pk
```
