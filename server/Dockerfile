FROM luxtagofficial/catapult-toolchain:0.2.0.2 as builder

ARG WORK_PATH=/tmp
ARG TMP_DIR=/tmp
ARG LIB_DIR=/usr/local
ARG WORKDIR=/opt/catapult

RUN mkdir -p ${WORK_PATH} \
  && apt-get update -y \
  && apt-get install make -y

WORKDIR ${WORK_PATH}

RUN if [ ! -d ${TMP_DIR}/catapult-server ]; then cd ${TMP_DIR} \
  && git clone https://github.com/nemtech/catapult-server.git -b master --depth 1; fi

RUN cd ${TMP_DIR}/catapult-server && mkdir -p _build && cd _build \
  && cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-pthread" \
    -DPYTHON_EXECUTABLE=/usr/bin/python3 \
    -DBSONCXX_LIB=${LIB_DIR}/lib/libbsoncxx.so \
    -DMONGOCXX_LIB=${LIB_DIR}/lib/libmongocxx.so \
    .. \
  && make publish && make -j4

RUN mkdir -p ${TMP_DIR}/deps && mkdir -p ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libboost_date_time* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libboost_filesystem* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libboost_log* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libboost_program_options* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libboost_thread* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libbson* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libmongo* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/librocksdb* ${TMP_DIR}/localdep \
	&& cp ${LIB_DIR}/lib/libzmq* ${TMP_DIR}/localdep \
	&& cp /usr/lib/x86_64-linux-gnu/libcrypto* ${TMP_DIR}/deps \
	&& cp /usr/lib/x86_64-linux-gnu/libgflags* ${TMP_DIR}/deps \
	&& cp /usr/lib/x86_64-linux-gnu/libsasl2* ${TMP_DIR}/deps \
	&& cp /usr/lib/x86_64-linux-gnu/libsnappy* ${TMP_DIR}/deps \
	&& cp /usr/lib/x86_64-linux-gnu/libssl* ${TMP_DIR}/deps \
	&& cp /usr/lib/x86_64-linux-gnu/libstdc* ${TMP_DIR}/deps

RUN mkdir -p ${WORKDIR}/bin/boost \
	&& cp ${TMP_DIR}/catapult-server/_build/bin/catapult* ${WORKDIR}/bin/ \
	&& cp ${TMP_DIR}/catapult-server/_build/bin/libcatapult* ${WORKDIR}/bin/ \
	&& cp ${TMP_DIR}/catapult-server/_build/bin/libextension* ${WORKDIR}/bin/ \
	&& cp -r ${TMP_DIR}/catapult-server/resources ${WORKDIR}/ \
	&& cp -r ${TMP_DIR}/catapult-server/_build/bin/boost ${WORKDIR}/bin/

FROM ubuntu:18.04

COPY --from=builder /opt/catapult /catapult
COPY --from=builder /tmp/deps /usr/lib/x86_64-linux-gnu
COPY --from=builder /tmp/localdep /usr/local/lib

WORKDIR /catapult

EXPOSE 7900 7901 7902

CMD ["/bin/bash"]