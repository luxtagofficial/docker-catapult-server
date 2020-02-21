FROM alpine:latest

LABEL MAINTAINER="Jonathan Tey <jonathan@luxtag.io>"

ARG TMP_DIR=/tmp

RUN mkdir -p ${TMP_DIR} \
  && apk update \
  && apk --no-cache add \
  g++ \
  git \
  linux-headers \
  make \
  python3 \
  snappy-dev

WORKDIR ${TMP_DIR}

COPY Makefile .

RUN make install