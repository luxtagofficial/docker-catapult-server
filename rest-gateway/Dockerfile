FROM node:10.18.0-alpine as builder

RUN apk add --update\
  git \
  python \
  python3 \
  build-base \
  zeromq-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /tmp

RUN git clone https://github.com/nemtech/catapult-rest.git -b master --depth 1

RUN cd /tmp/catapult-rest/catapult-sdk \
  && yarn install \
  && yarn rebuild

RUN cd /tmp/catapult-rest/rest \
  && yarn install \
  && yarn build

FROM node:10.18.0-alpine

ARG SOURCE_DIR=/tmp/catapult-rest

WORKDIR /app

COPY --from=builder ${SOURCE_DIR}/rest/package.json /app/
COPY --from=builder ${SOURCE_DIR}/rest/_build /app/_build
COPY --from=builder ${SOURCE_DIR}/rest/resources /app/resources
COPY --from=builder ${SOURCE_DIR}/rest/node_modules /app/node_modules
COPY --from=builder ${SOURCE_DIR}/catapult-sdk /app/node_modules/catapult-sdk


EXPOSE 3000
CMD ["npm", "start", "resources/rest.json", "/userconfig/rest.json"]
