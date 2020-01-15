.PHONY: server server-* toolchain

server:
	docker build --build-arg CATAPULT_VERSION=${VERSION} -t luxtagofficial/catapult-server:${VERSION} server

server-keccak:
	docker build --build-arg CATAPULT_VERSION=${VERSION} --build-arg USE_KECCAK=${USE_KECCAK} -t luxtagofficial/catapult-server:${VERSION}-keccak server

server-alpine:
	docker build --build-arg CATAPULT_VERSION=${VERSION} -t luxtagofficial/catapult-server:${VERSION} server/alpine

server-alpine-keccak:
	docker build --build-arg CATAPULT_VERSION=${VERSION} --build-arg USE_KECCAK=${USE_KECCAK} -t luxtagofficial/catapult-server:${VERSION}-keccak server/alpine

toolchain:
	docker build --build-arg CATAPULT_VERSION=${VERSION} -t luxtagofficial/catapult-toolchain:${VERSION} toolchain