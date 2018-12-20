TMP_DIR := /tmp
LIB_DIR := /usr/local
WORKDIR := /opt/catapult

install:
	make install-catapult
	@echo "✔ Done!"

package-dependencies:
	@echo "→ moving dependencies"
	mkdir -p ${TMP_DIR}/deps && mkdir -p ${TMP_DIR}/localdep \
  && cp ${LIB_DIR}/lib/libboost_atomic* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_chrono* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_date_time* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_filesystem* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_log* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_program_options* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_regex* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_system* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_thread* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libboost_timer* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/librocksdb* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libzmq* ${TMP_DIR}/deps \
  # && cp /usr/lib/x86_64-linux-gnu/libnuma* ${TMP_DIR}/deps \
  && cp /usr/lib/x86_64-linux-gnu/libgflags* ${TMP_DIR}/deps \
  && cp /usr/lib/x86_64-linux-gnu/libsnappy* ${TMP_DIR}/deps \
  && cp ${LIB_DIR}/lib/libmongo* ${TMP_DIR}/localdep \
  && cp ${LIB_DIR}/lib/libbson* ${TMP_DIR}/localdep
	@echo "✔ Done!"

production:
	make package-dependencies
	@echo "→ packaging catapult for production"
	cp ${TMP_DIR}/catapult-server/_build/bin/catapult* ${WORKDIR}/bin/
	cp ${TMP_DIR}/catapult-server/_build/bin/libextension* ${WORKDIR}/bin/
	cp ${TMP_DIR}/catapult-server/_build/bin/boost* ${WORKDIR}/bin/boost
	@echo "✔ Done!"

install-catapult:
	@echo "→ installing: catapult (master)"
	if [ ! -d ${TMP_DIR}/catapult-server ]; then cd ${TMP_DIR} \
		&& git clone https://github.com/nemtech/catapult-server.git -b master --depth 1; fi

	cd ${TMP_DIR}/catapult-server && mkdir -p _build && cd _build \
  	&& cmake -DCMAKE_BUILD_TYPE=Release \
	    -DCMAKE_CXX_FLAGS="-pthread" \
	    -DPYTHON_EXECUTABLE=/usr/bin/python3 \
	    -DBSONCXX_LIB=${LIB_DIR}/lib/libbsoncxx.so \
	    -DMONGOCXX_LIB=${LIB_DIR}/lib/libmongocxx.so \
	    .. \
  	&& make publish && make -j4
	@echo "✔ done: catapult (master) is installed"