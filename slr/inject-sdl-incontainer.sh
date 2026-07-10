#!/bin/bash
# Build the FFB-fixed SDL3 (s8n/SDL-g29) + a matching sdl2-compat and drop the
# shared objects into a Proton redist tree's files/lib/{x86_64,i386}-linux-gnu.
#
# MUST run INSIDE the steamrt4 SDK container so the libraries are ABI-compatible
# with the runtime they'll execute in. Invoked via `docker run ... <sdk-image>`
# with the SDL sources and the redist tree bind-mounted, e.g.:
#
#   docker run --rm \
#     -v $SDL3_SRC:$SDL3_SRC -v $SDL2COMPAT_SRC:$SDL2COMPAT_SRC \
#     -v $DEST:$DEST -v $PWD/inject-sdl-incontainer.sh:/inject.sh \
#     -e SDL3_SRC -e SDL2COMPAT_SRC -e DEST \
#     $SDK_IMAGE bash /inject.sh
#
# winebus dlopen("libSDL2-2.0.so.0") -> our sdl2-compat -> our fixed libSDL3.so.0.
# The proton launcher prepends these dirs to LD_LIBRARY_PATH so they win.
set -euo pipefail

SDL3_SRC=${SDL3_SRC:?set SDL3_SRC to the SDL-g29 checkout}
SDL2COMPAT_SRC=${SDL2COMPAT_SRC:?set SDL2COMPAT_SRC to the sdl2-compat source}
DEST=${DEST:?set DEST to the redist .../files/lib dir}
WORK=${WORK:-/tmp/sdlbuild}

command -v cmake  >/dev/null || { echo "cmake missing in container" >&2; exit 2; }
gcc -m32 -x c -c /dev/null -o /dev/null 2>/dev/null || \
    echo "WARNING: gcc -m32 probe failed; 32-bit SDL build may not work" >&2

mkdir -p "$WORK"
for arch in 64 32; do
    if [ "$arch" = 64 ]; then triplet=x86_64-linux-gnu; mflag=""; else triplet=i386-linux-gnu; mflag="-m32"; fi
    echo "=== building SDL3 ($arch-bit) ==="
    CC="gcc $mflag" CXX="g++ $mflag" \
    cmake -S "$SDL3_SRC" -B "$WORK/sdl3-$arch" \
        -D CMAKE_BUILD_TYPE=None -D CMAKE_INSTALL_PREFIX=/usr \
        -D SDL_STATIC=OFF -D SDL_RPATH=OFF -D SDL_TEST_LIBRARY=OFF
    cmake --build "$WORK/sdl3-$arch" -- -j"$(nproc)"
    DESTDIR="$WORK/sdl3-stage-$arch" cmake --install "$WORK/sdl3-$arch"

    echo "=== building sdl2-compat ($arch-bit) ==="
    CC="gcc $mflag" CXX="g++ $mflag" \
    cmake -S "$SDL2COMPAT_SRC" -B "$WORK/sdl2c-$arch" \
        -D CMAKE_BUILD_TYPE=None -D CMAKE_INSTALL_PREFIX=/usr \
        -D CMAKE_PREFIX_PATH="$WORK/sdl3-stage-$arch/usr" -D SDL2COMPAT_TESTS=OFF
    cmake --build "$WORK/sdl2c-$arch" -- -j"$(nproc)"

    echo "=== installing into $DEST/$triplet ==="
    install -d "$DEST/$triplet"
    cp -a "$WORK/sdl3-$arch"/libSDL3.so.0* "$WORK/sdl2c-$arch"/libSDL2-2.0.so.0* "$DEST/$triplet/"
    ls -l "$DEST/$triplet"/libSDL{3,2-2.0}.so.0*
done
echo "=== SDL injection complete ==="
