FROM ubuntu:18.04

LABEL MAINTAINER="Jonathan Tey <jonathan@luxtag.io>"

ARG TMP_DIR=/tmp

RUN mkdir -p ${TMP_DIR} \
	&& apt-get update -y \
	&& apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		build-essential \
		g++-7 \
		gcc-7 \
		git \
		libatomic-ops-dev \
		libc6-dev \
		libgflags-dev \
		libsasl2-dev \
		libsnappy-dev \
		libssl-dev \
		libtool \
		libunwind-dev \
		make \
		pkg-config \
		python-dev \
		python3 \
		software-properties-common \
		wget \
		xz-utils \
		&& apt-get clean && rm -rf /var/lib/apt/lists/* \
		&& rm /usr/bin/gcc /usr/bin/g++ \
		&& ln -s /usr/bin/gcc-7 /usr/bin/gcc \
		&& ln -s /usr/bin/g++-7 /usr/bin/g++

WORKDIR ${TMP_DIR}

COPY Makefile .

RUN make install
