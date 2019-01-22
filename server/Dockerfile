FROM luxtagofficial/catapult-toolchain:0.2.0.2 as builder

ARG WORK_PATH=/tmp

RUN mkdir -p ${WORK_PATH} \
  && apt-get update -y \
  && apt-get install make -y

WORKDIR ${WORK_PATH}

COPY Makefile .

RUN make install

RUN make production


FROM ubuntu:18.04

ARG WORK_DIR=/catapult

RUN mkdir -p ${WORK_DIR}/bin/deps

COPY --from=builder /opt/catapult/ ${WORK_DIR}
COPY --from=builder /tmp/deps/ ${WORK_DIR}/bin/deps
COPY --from=builder /tmp/localdep/ /usr/local/lib

WORKDIR ${WORK_DIR}

EXPOSE 7900 7901 7902

CMD ["/bin/bash"]