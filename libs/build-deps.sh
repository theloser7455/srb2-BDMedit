#!/bin/sh
build_cmake() {
	mkdir -p build && cd build
	if ! cmake -DCMAKE_SYSTEM_NAME=Windows \
		-DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc \
		-DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++ \
		-DCMAKE_FIND_ROOT_PATH=/usr/x86_64-w64-mingw32 \
		-DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY $@ ..; then
		echo 'Configuration failed'
		exit 1
	fi
	if ! make -j$cpus; then
		echo 'Build failed'
		exit 1
	fi
}

root="$(pwd)"
echo "Lib path: $root"

printf 'Figuring out CPU count...'
if [ -r /proc/cpuinfo ]; then
	cpus="$(grep processor /proc/cpuinfo | wc -l)"
	echo "done ($cpus)"
else
	echo 'failed (build will not be parallelized)'
	cpus=1
fi

echo 'Compiling SDL3...'
cd "$root/SDL3"
build_cmake

echo 'Compiling SDL3_mixer...'
cd "$root/SDL3_mixer"
build_cmake -DSDL3_DIR="$root/SDL3/build" \
	-Dgme_LIBRARY="$root/dll-binaries/x86_64/libgme.dll" \
	-Dgme_INCLUDE_PATH="$root/gme/include"
echo 'Done'
