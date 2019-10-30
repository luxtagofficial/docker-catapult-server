FROM alpine:latest

LABEL MAINTAINER="Jonathan Tey <jonathan@luxtag.io>"

ARG TMP_DIR=/tmp

RUN mkdir -p ${TMP_DIR} \
  && apk update \
  && apk --no-cache add \
  cmake \
  curl \
  g++ \
  git \
  make \
  python3 \
  linux-headers \
  snappy-dev

WORKDIR ${TMP_DIR}

COPY Makefile .

RUN make parallel-install