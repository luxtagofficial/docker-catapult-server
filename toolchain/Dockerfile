FROM ubuntu:18.04

ARG TMP_DIR=/tmp

RUN mkdir -p ${TMP_DIR} \
  && apt-get update -y \
  && apt-get install make -y

WORKDIR ${TMP_DIR}

COPY Makefile .

RUN make install-dependencies

RUN make parallel-install