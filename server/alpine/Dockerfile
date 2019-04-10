FROM luxtagofficial/catapult-toolchain:0.3.0.2-alpine as builder

ARG WORK_PATH=/tmp
ARG TMP_DIR=/tmp
ARG WORKDIR=/opt/catapult

RUN mkdir -p ${WORK_PATH} \
  && apk update \
  && apk add --no-cache ninja python3

WORKDIR ${WORK_PATH}

RUN if [ ! -d ${WORK_PATH}/catapult-server ]; then cd ${WORK_PATH} \
  && git clone https://github.com/nemtech/catapult-server.git -b master --depth 1; fi

RUN cd ${WORK_PATH}/catapult-server && mkdir -p _build && cd _build \
  && cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-pthread" \
    -DPYTHON_EXECUTABLE=/usr/bin/python3 \
		-G Ninja \
    .. \
  && ninja publish && ninja -j4

RUN mkdir -p ${TMP_DIR}/deps && mkdir -p ${TMP_DIR}/localdep && mkdir -p ${TMP_DIR}/localdep64 \
	&& cp /usr/lib/libgcc* ${TMP_DIR}/deps \
	&& cp /usr/lib/libstdc++* ${TMP_DIR}/deps \
	&& cp /usr/local/lib/libboost_chrono* ${TMP_DIR}/localdep \
	&& cp /usr/local/lib/libboost_date_time* ${TMP_DIR}/localdep \
	&& cp /usr/local/lib/libboost_filesystem* ${TMP_DIR}/localdep \
	&& cp /usr/local/lib/libboost_log* ${TMP_DIR}/localdep \
	&& cp /usr/local/lib/libboost_program_options* ${TMP_DIR}/localdep \
	&& cp /usr/local/lib/libboost_thread* ${TMP_DIR}/localdep \
	&& cp /usr/local/lib64/libbson* ${TMP_DIR}/localdep64 \
	&& cp /usr/local/lib64/libmongo* ${TMP_DIR}/localdep64 \
	&& cp /usr/local/lib64/librocksdb* ${TMP_DIR}/localdep64 \
	&& cp /usr/local/lib64/libzmq* ${TMP_DIR}/localdep64

RUN mkdir -p ${WORKDIR}/bin/boost \
	&& cp ${WORK_PATH}/catapult-server/_build/bin/catapult* ${WORKDIR}/bin/ \
	&& cp ${WORK_PATH}/catapult-server/_build/bin/libcatapult* ${WORKDIR}/bin/ \
	&& cp ${WORK_PATH}/catapult-server/_build/bin/libextension* ${WORKDIR}/bin/ \
	&& cp -r ${WORK_PATH}/catapult-server/resources ${WORKDIR}/ \
	&& cp -r ${WORK_PATH}/catapult-server/_build/bin/boost ${WORKDIR}/bin/

FROM alpine:latest

LABEL MAINTAINER="Jonathan Tey <jonathan@luxtag.io>"

COPY --from=builder /opt/catapult /catapult
COPY --from=builder /tmp/deps /usr/lib/
COPY --from=builder /tmp/localdep /usr/local/lib
COPY --from=builder /tmp/localdep64 /usr/local/lib64

WORKDIR /catapult

EXPOSE 7900 7901 7902

CMD ["/bin/sh"]