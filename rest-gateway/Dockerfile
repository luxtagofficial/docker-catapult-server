FROM node:8.15.0-alpine as builder

RUN apk add --update\
  git \
  python \
  python3 \
  build-base \
  zeromq-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /app

RUN git clone https://github.com/nemtech/catapult-rest/ /app

RUN cd /app/catapult-sdk \
  && yarn install \
  && yarn rebuild

RUN cd /app/rest \
  && yarn install \
  && yarn build

FROM node:8.15.0-alpine

WORKDIR /app

COPY --from=builder /app/rest/package.json /app/
COPY --from=builder /app/rest/_build /app/_build
COPY --from=builder /app/rest/resources /app/resources
COPY --from=builder /app/rest/node_modules /app/node_modules
COPY --from=builder /app/catapult-sdk /app/node_modules/catapult-sdk


EXPOSE 3000
CMD ["npm", "start", "resources/rest.json", "/userconfig/rest.json"]