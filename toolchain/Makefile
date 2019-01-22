TMP_DIR := /tmp
LIB_DIR := /usr/local

### utilities ###
clean:
	rm -rf ${TMP_DIR}/*

### installation overview ###
install:
	make install-dependencies
	make parallel-install
	@echo "✔ Done!"

parallel-install: install-cmake install-boost
	make parallel-install-step-2

parallel-install-step-2: install-gtest install-rocksdb install-zmqlib install-mongoc install-mongocxx
	make install-cppzmq
	@echo "✔ parallel-step-2 completed"

### installation details ###
install-dependencies:
	@echo "→ installing dependencies.."
	apt-get update -y && apt-get clean && apt-get install -y --no-install-recommends \
		git \
		wget \
		autoconf \
		automake \
		apt-file \
		build-essential \
		software-properties-common \
		pkg-config \
		python3 \
		python-dev \
		libc6-dev \
		libssl-dev \
		libsasl2-dev \
		libgflags-dev \
		libsnappy-dev \
		libtool \
		gcc-7 \
		g++-7 \
		&& apt-get clean && rm -rf /var/lib/apt/lists/* \
		&& rm /usr/bin/gcc /usr/bin/g++ \
		&& ln -s /usr/bin/gcc-7 /usr/bin/gcc \
		&& ln -s /usr/bin/g++-7 /usr/bin/g++

install-cmake:
	@echo "→ installing: cmake v3.11.1"
	if [ ! -d ${TMP_DIR}/cmake ]; then cd ${TMP_DIR} \
		&& git clone https://gitlab.kitware.com/cmake/cmake.git -b v3.11.1 --depth 1; fi

	cd ${TMP_DIR}/cmake && ./bootstrap --prefix=${LIB_DIR} && make -j4 && make install \
		&& rm -r ${TMP_DIR}/cmake
	@echo "✔ done: cmake v3.11.1 is installed"

install-boost:
	@echo "→ installing: boost 1.65.1"
	if [ ! -d ${TMP_DIR}/boost_1_65_1 ]; then cd ${TMP_DIR} \
		&& wget https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz \
		&& tar xzf boost_1_65_1.tar.gz; fi

	cd ${TMP_DIR}/boost_1_65_1 && ./bootstrap.sh && ./b2 toolset=gcc install --prefix=${LIB_DIR} -j4 \
		&& rm -r ${TMP_DIR}/boost_1_65_1
	@echo "✔ done: boost 1.65.1 is installed"

install-gtest:
	@echo "→ installing: gtest release-1.8.0"
	if [ ! -d ${TMP_DIR}/googletest ]; then cd ${TMP_DIR} && git clone https://github.com/google/googletest.git -b release-1.8.0 --depth 1; fi

	cd ${TMP_DIR}/googletest && mkdir -p googletest/_build \
		&& cd googletest/_build \
		&& cmake -DCMAKE_INSTALL_PREFIX=${LIB_DIR} .. && make -j4 && make install \
		&& rm -r ${TMP_DIR}/googletest
	@echo "✔ done: gtest release-1.8.0 is installed"

install-rocksdb:
	@echo "→ installing: rocksdb v5.12.4"
	if [ ! -d ${TMP_DIR}/rocksdb ]; then cd ${TMP_DIR} \
		&& git clone https://github.com/facebook/rocksdb.git -b v5.12.4 --depth 1; fi

	mkdir -p ${TMP_DIR}/rocksdb/_build && cd ${TMP_DIR}/rocksdb/_build \
		&& cmake -DCMAKE_INSTALL_PREFIX=${LIB_DIR} .. && make -j4 && make install \
		&& rm -r ${TMP_DIR}/rocksdb
	@echo "✔ done: rocksdb v5.12.4"

install-zmqlib:
	@echo "→ installing: zmqlib v4.2.3"
	if [ ! -d ${TMP_DIR}/libzmq ]; then cd ${TMP_DIR} \
		&& git clone https://github.com/zeromq/libzmq.git -b v4.2.3 --depth 1; fi

	mkdir -p ${TMP_DIR}/libzmq/_build && cd ${TMP_DIR}/libzmq/_build \
		&& cmake -DCMAKE_INSTALL_PREFIX=${LIB_DIR} .. && make -j4 && make install \
		&& rm -r ${TMP_DIR}/libzmq
	@echo "✔ done: zmqlib v4.2.3 is installed"

install-cppzmq:
	@echo "→ installing: cppzmq v4.2.3"
	if [ ! -d ${TMP_DIR}/cppzmq ]; then cd ${TMP_DIR} \
		&& git clone https://github.com/zeromq/cppzmq.git -b v4.2.3 --depth 1; fi

	mkdir -p ${TMP_DIR}/cppzmq/_build && cd ${TMP_DIR}/cppzmq/_build \
		&& cmake -DCMAKE_INSTALL_PREFIX=${LIB_DIR} .. && make -j4 && make install \
		&& rm -r ${TMP_DIR}/cppzmq
	@echo "✔ done: cppzmq v4.2.3 is installed"

install-mongoc:
	@echo "→ installing: mongoc 1.11.0"
	if [ ! -d ${TMP_DIR}/mongo-c-driver ]; then cd ${TMP_DIR} \
		&& git clone https://github.com/mongodb/mongo-c-driver.git -b 1.11.0 --depth 1; fi

	cd ${TMP_DIR}/mongo-c-driver/build \
		&& cmake -DCMAKE_BUILD_TYPE="Release" -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF -DCMAKE_INSTALL_PREFIX=${LIB_DIR} .. \
		&& make -j4 && make install \
		&& rm -r ${TMP_DIR}/mongo-c-driver
	@echo "✔ done: mongoc 1.11.0 is installed"

install-mongocxx:
	@echo "→ installing: mongocxx r3.3"
	if [ ! -d ${TMP_DIR}/mongo-cxx-driver ]; then cd ${TMP_DIR} \
		&& git clone https://github.com/mongodb/mongo-cxx-driver.git -b releases/v3.3 --depth 1; fi

	cd ${TMP_DIR}/mongo-cxx-driver/build \
		&& cmake -DBSONCXX_POLY_USE_BOOST=1 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${LIB_DIR} .. \
		&& make -j4 && make install \
		&& rm -r ${TMP_DIR}/mongo-cxx-driver
	@echo "✔ done: mongocxx r3.3 is installed"
