# NEM Catapult Server - Ubuntu

Dockerfile build for NEM catapult server
Based on:

- https://github.com/nemtech/catapult-server
- https://github.com/44uk/catapult-server-docker
- https://github.com/AENCO-Global/Docker-Profiles/

### Usage

This repo has been split into two parts, a toolchain with all dependencies prebuilt and server, which builds the catapult server and bundles it into a docker image.

You can build the toolchain or use our precompiled bundle. If you want to use the precompiled toolchain, skip to "Compiling catapult".

#### Building the toolchain

```
$ cd toolchain/
$ docker build -t nem-catapult-toolchain .
```

Once completed, edit the first line of `server/Dockerfile`.

```
// Change this line
// FROM luxtagofficial/catapult-toolchain:0.2.0.2 as builder

// To
FROM nem-catapult-toolchain as builder
```

#### Compiling catapult

```
$ cd server
$ docker build -t nem-catapult .
```
