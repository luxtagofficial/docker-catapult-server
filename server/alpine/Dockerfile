FROM luxtagofficial/catapult-toolchain:0.1.0.1-alpine as builder

ARG WORK_PATH=/tmp
ARG TMP_DIR=/tmp
ARG WORKDIR=/opt/catapult

RUN mkdir -p ${WORK_PATH} \
  && apk update \
  && apk add --no-cache python3

WORKDIR ${WORK_PATH}

RUN if [ ! -d ${WORK_PATH}/catapult-server ]; then cd ${WORK_PATH} \
  && git clone https://github.com/luxtagofficial/catapult-server.git -b v0.1.0.1-modifyMaxCosignedAccounts --depth 1; fi

RUN cd ${WORK_PATH}/catapult-server && mkdir -p _build && cd _build \
  && cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-pthread -Wno-error=class-memaccess" \
    -DPYTHON_EXECUTABLE=/usr/bin/python3 \
    -DBSONCXX_LIB=/usr/local/lib64/libbsoncxx.so \
    -DMONGOCXX_LIB=/usr/local/lib64/libmongocxx.so \
    .. \
  && make publish && make -j4

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
