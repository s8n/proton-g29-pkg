# Maintainer: ave
# Based on proton-cachyos-native by:
#   Peter Jung ptr1337 <admin@ptr1337.dev>
#   loathingkernel <loathingkernel _a_ gmail _d_ com>

pkgname=proton-g29
_srctag=11.0-20260702
_srcbranch=cachyos_11.0_20260702/g29
_commit=
pkgver=${_srctag//-/.}
_geckover=2.47.4
_monover=11.2.0
_xaliaver=0.4.9
_sdl3branch=donotupstream-g29-ffb-fixes/3.4.12
_sdl2compatver=2.32.70
pkgrel=1
epoch=1

source=(
  proton-cachyos::git+https://github.com/s8n/proton-g29.git#branch=${_srcbranch}
  https://dl.winehq.org/wine/wine-gecko/${_geckover}/wine-gecko-${_geckover}-x86{,_64}.tar.xz
  https://github.com/madewokherd/wine-mono/releases/download/wine-mono-${_monover}/wine-mono-${_monover}-x86.tar.xz
  https://github.com/madewokherd/xalia/releases/download/xalia-${_xaliaver}/xalia-${_xaliaver}-net48-mono.zip
  sdl3-g29::git+https://github.com/s8n/SDL-g29.git#branch=${_sdl3branch}
  sdl2-compat-${_sdl2compatver}.tar.gz::https://github.com/libsdl-org/sdl2-compat/releases/download/release-${_sdl2compatver}/sdl2-compat-${_sdl2compatver}.tar.gz
  compatibilitytool.vdf.template
  ntsync.conf
)
noextract=(
  wine-gecko-${_geckover}-{x86,x86_64}.tar.xz
  wine-mono-${_monover}-x86.tar.xz
  xalia-${_xaliaver}-net48-mono.zip
)

pkgdesc="proton-cachyos (native build) with Logitech G29 wheel fixes: native axis mapping, report order, unsigned axis ranges and SDL force feedback"
url="https://github.com/s8n/proton-g29"
arch=(x86_64 x86_64_v3)
options=(!staticlibs !lto !debug emptydirs pestrip)
license=('custom')
depends=(
  attr            lib32-attr
#  blas            lib32-blas
  cabextract
  desktop-file-utils
  fontconfig      lib32-fontconfig
  flac            lib32-flac
  freetype2       lib32-freetype2
  libgcc          lib32-gcc-libs
  gettext         lib32-gettext
  glib2           lib32-glib2
  glibc           lib32-glibc
#  lapack          lib32-lapack
  libgudev        lib32-libgudev
  libnsl          lib32-libnsl
  libpcap         lib32-libpcap
  libunwind       lib32-libunwind
  libvpx          lib32-libvpx
  libwebp         lib32-libwebp
  libx11          lib32-libx11
  libxcursor      lib32-libxcursor
  libxext         lib32-libxext
  libxkbcommon    lib32-libxkbcommon
  libxml2         lib32-libxml2
  libxi           lib32-libxi
  libxrandr       lib32-libxrandr
  pipewire        lib32-pipewire
  python
  python-six
  speex           lib32-speex
  speexdsp        lib32-speexdsp
# Start of old steam-native-runtime
  atk             lib32-atk
  cairo           lib32-cairo
  curl            lib32-curl
  dbus-glib       lib32-dbus-glib
  freeglut        lib32-freeglut
  gdk-pixbuf2     lib32-gdk-pixbuf2
  glu             lib32-glu
  lcms2           lib32-lcms2
  libcaca         lib32-libcaca
  libcanberra     lib32-libcanberra
  dbus            lib32-dbus
  libdrm          lib32-libdrm
  libice          lib32-libice
  libibus
  libnm           lib32-libnm
  libusb          lib32-libusb
  libvdpau        lib32-libvdpau
  libvorbis       lib32-libvorbis
  libxft          lib32-libxft
  libxmu          lib32-libxmu
  libxrender      lib32-libxrender
  libxtst         lib32-libxtst
  nspr            lib32-nspr
  openal          lib32-openal
  pango           lib32-pango
  sdl2            lib32-sdl2
  sdl2_image      lib32-sdl2_image
  sdl2_mixer      lib32-sdl2_mixer
  sdl2_ttf        lib32-sdl2_ttf
  pipewire        lib32-pipewire
  librsvg
  libsm           lib32-libsm
  libtheora       lib32-libtheora
  vulkan-driver   lib32-vulkan-driver
# End of old steam-native-runtime
  unzip
  wayland         lib32-wayland
  xz              lib32-xz
)
makedepends=(
  afdko
  alsa-lib              lib32-alsa-lib
  clang
  cmake
  ffmpeg
  fontforge
  giflib                lib32-giflib
  git
  glib2-devel
  glslang 
  gnutls                lib32-gnutls
  gtk3                  lib32-gtk3
  libgphoto2
  libpulse              lib32-libpulse
  libva                 lib32-libva
  libxcomposite         lib32-libxcomposite
  libxinerama           lib32-libxinerama
  libxxf86vm            lib32-libxxf86vm
  lld
  mesa                  lib32-mesa
  mesa-libgl            lib32-mesa-libgl
  meson
  mingw-w64-gcc
  mingw-w64-tools
  nasm
  opencl-headers
  opencl-icd-loader     lib32-opencl-icd-loader
  pcsclite              lib32-pcsclite
  perl
  perl-json
  rsync
  rust                  lib32-rust-libs
  python-pefile
  python-setuptools-scm
  samba
  unixodbc
  v4l-utils             lib32-v4l-utils
  vulkan-headers
  vulkan-icd-loader     lib32-vulkan-icd-loader
  wayland-protocols
  wget
  xorg-util-macros
)
optdepends=(
  alsa-lib              lib32-alsa-lib
  alsa-plugins          lib32-alsa-plugins
  ffmpeg
  gnutls                lib32-gnutls
  gtk3                  lib32-gtk3
  libgphoto2
  libpulse              lib32-libpulse
  libva                 lib32-libva
  libxcomposite         lib32-libxcomposite
  libxinerama           lib32-libxinerama
  opencl-icd-loader     lib32-opencl-icd-loader
  pcsclite              lib32-pcsclite
  samba
  steam
  umu-launcher
  unixodbc
  v4l-utils             lib32-v4l-utils
  vulkan-icd-loader     lib32-vulkan-icd-loader
)
optdepends+=(
  NTSYNC-MODULE
)
provides=('proton')
replaces=('proton-cachyos')
backup=(
  "usr/share/steam/compatibilitytools.d/${pkgname}/user_settings.py"
)
install=${pkgname}.install

_make_wrappers () {
    #     _arch     prefix   gcc    ld             as     strip
    local _i686=(  "i686"   "-m32" "-melf_i386"   "--32" "elf32-i386")
    local _x86_64=("x86_64" "-m64" "-melf_x86_64" "--64" "elf64-x86-64")
    local _opts=(_i686 _x86_64)
    local _trip
    declare -n _opt
    for _opt in "${_opts[@]}"; do
        # the 20260702 tree uses bare <arch>-linux-gnu- prefixes (steamrt
        # style); keep the -pc- spelling too for anything still using it
        for _trip in "${_opt[0]}-pc-linux-gnu" "${_opt[0]}-linux-gnu"; do
            for l in ar ranlib nm; do
                ln -s /usr/bin/gcc-$l wrappers/${_trip}-$l
            done
            for t in gcc g++; do
                install -Dm755 /dev/stdin wrappers/${_trip}-$t <<EOF
#!/usr/bin/bash
$(which ccache 2> /dev/null) /usr/bin/$t ${_opt[1]} "\$@"
EOF
            done
            install -Dm755 /dev/stdin wrappers/${_trip}-ld <<EOF
#!/usr/bin/bash
/usr/bin/ld ${_opt[2]} "\$@"
EOF
            install -Dm755 /dev/stdin wrappers/${_trip}-as <<EOF
#!/usr/bin/bash
/usr/bin/as ${_opt[3]} "\$@"
EOF
            install -Dm755 /dev/stdin wrappers/${_trip}-strip <<EOF
#!/usr/bin/bash
/usr/bin/strip -F ${_opt[4]} "\$@"
EOF
            # host pkg-config: the build rules steer the target arch through a
            # Debian-multiarch PKG_CONFIG_LIBDIR (same wrapper name for both
            # arches), so translate those dirs to their Arch equivalents
            install -Dm755 /dev/stdin wrappers/${_trip}-pkg-config <<'EOF'
#!/usr/bin/bash
if [ -n "$PKG_CONFIG_LIBDIR" ]; then
    PKG_CONFIG_LIBDIR=$(printf '%s' "$PKG_CONFIG_LIBDIR" | sed \
        -e 's|/usr/lib/i386-linux-gnu/pkgconfig|/usr/lib32/pkgconfig|g' \
        -e 's|/usr/lib/x86_64-linux-gnu/pkgconfig|/usr/lib/pkgconfig|g')
    export PKG_CONFIG_LIBDIR
fi
exec /usr/bin/pkg-config "$@"
EOF
        done
    done
}

prepare() {

    # Provide wrappers to compiler tools
    rm -rf wrappers && mkdir wrappers
    _make_wrappers

    # Fake container engine for containerless (native) builds: the 20260702
    # tree dropped the "none" engine support from configure.sh/Makefile.in,
    # so emulate `<engine> run --rm [opts] <image> <cmd...>` by running the
    # command on the host. Mount sources equal their destinations in the
    # Makefile invocations; the configure.sh permission probe mounts pwd at
    # /test, so destination prefixes are translated back to their sources.
    install -Dm755 /dev/stdin wrappers/none <<'EOF'
#!/bin/bash
[ "$1" = run ] && shift
declare -a maps args
wd=.
while [ $# -gt 0 ]; do
    case "$1" in
        --rm) shift ;;
        -v) maps+=("$2"); shift 2 ;;
        -w) wd="$2"; shift 2 ;;
        -e) case "$2" in *=*) export "$2" ;; esac; shift 2 ;;
        -u) shift 2 ;;
        *) break ;;
    esac
done
shift # image
for a in "$@"; do
    for m in "${maps[@]}"; do
        src="${m%%:*}"; rest="${m#*:}"; dst="${rest%%:*}"
        [ "$src" != "$dst" ] && a="${a/#"$dst"/"$src"}"
    done
    args+=("$a")
done
[ ${#args[@]} -eq 0 ] && exit 0
cd "$wd" && exec "${args[@]}"
EOF

    # the 20260702 tree invokes afdko font tools through an `afdko <tool>`
    # dispatcher (steamrt packaging); Arch ships the subtools directly on PATH
    install -Dm755 /dev/stdin wrappers/afdko <<'EOF'
#!/usr/bin/bash
exec "$@"
EOF

    [ ! -d build ] && mkdir build

    cd proton-cachyos

    [ ! -d contrib ] && mkdir -p contrib
    mv "$srcdir"/wine-gecko-${_geckover}-x86{,_64}.tar.xz contrib/
    mv "$srcdir"/wine-mono-${_monover}-x86.tar.xz contrib/
    mv "$srcdir"/xalia-${_xaliaver}-net48-mono.zip contrib/

    _submodules=(
        FEX
        OpenXR-SDK
        SPIRV-Headers
        Vulkan-Headers
        Vulkan-Loader
        dav1d
        dxvk
        dxvk-nvapi
        extras/d7vk
        extras/discord-rpc-bridge
        extras/dxvk-low-latency
        extras/dxvk-sarek
        ffmpeg
        fonts/liberation-fonts
        glslang
        graphene
        gst-libav
        gst-orc
        gst-plugins-rs
        gstreamer
        libsoup
        meson
        nvidia-libs/dxvk-nvapi
        nvidia-libs/nvcuda
        nvidia-libs/nvcuda32
        nvidia-libs/nvenc
        nvidia-libs/nvenc32
        nvidia-libs/wine-nvml
        nvidia-libs/wine-nvoptix
        openvr
        protonfixes
        vkd3d
        vkd3d-proton
        vklayers/Vulkan-Utility-Libraries
        vklayers/low_latency_layer
        vklayers/pyroveil
        vklayers/vkbasalt
        wine
    )
    # TTS (kaldi, openfst, piper, vosk-api) and steamrtdeps/* submodules are
    # skipped: the build configures --without-tts --without-steamrt-depends.

    # libsoup's GSSAPI auth code doesn't build 32-bit against host glib
    # (size_t* vs gsize* on ILP32 is an error since GCC 14); games don't
    # need kerberos HTTP auth, disable it
    grep -q 'gssapi=disabled' Makefile.in || \
        sed -i 's|-Dautobahn=disabled \\|-Dautobahn=disabled \\\n\t-Dgssapi=disabled \\|' Makefile.in

    # the 20260702 wine merge lost configure.ac's Linux OpenCL detection
    # (AC_CHECK_LIB(OpenCL,...) — present in 20260602 at line 1470), so
    # opencl.so links without -lOpenCL and fails; pass the libs explicitly
    grep -q 'OPENCL_LIBS' Makefile.in || \
        sed -i 's|^  --without-oss \\|  --without-oss \\\n  OPENCL_LIBS=-lOpenCL \\|' Makefile.in

    # Explicitly set origin URL for submodules using relative paths
    git remote set-url origin https://github.com/s8n/proton-g29.git
    # The wine submodule resolves to s8n/wine-g29 (the G29 fixes) via .gitmodules.
    # Only pass paths that are actual gitlinks in this branch's tree (.gitmodules
    # can carry stale entries from other branches), so submodule drift between
    # releases warns instead of hard-failing.
    local _sm _wanted=()
    for _sm in "${_submodules[@]}"; do
        if git ls-files --stage -- "${_sm}" | grep -q '^160000'; then
            _wanted+=("${_sm}")
        else
            warning "submodule ${_sm} is not a gitlink in this tree, skipping"
        fi
    done
    git submodule update --init --filter=tree:0 --recursive "${_wanted[@]}"

    for rustlib in gst-plugins-rs; do
    pushd $rustlib
        export RUSTUP_TOOLCHAIN=stable
        export CARGO_HOME="${SRCDEST}"/proton-cargo
        export CARGO_NET_GIT_FETCH_WITH_CLI=true
        cargo fetch --locked --target i686-unknown-linux-gnu
        cargo fetch --locked --target x86_64-unknown-linux-gnu
    popd
    done
}

build() {
    export PATH="$(pwd)/wrappers:$PATH"

    local -a split=($CFLAGS)
    local -A flags
    for opt in "${split[@]}"; do flags["${opt%%=*}"]="${opt##*=}"; done
    local march="${flags["-march"]:-nocona}"
    local mtune="${flags["-mtune"]:-core-avx2}"

    CFLAGS="-O2 -march=${march} -mtune=${mtune}"
    CXXFLAGS="-O2 -march=${march} -mtune=${mtune}"
    RUSTFLAGS="-C opt-level=3 -C target-cpu=${march}"
    LDFLAGS="-Wl,-O1,--sort-common,--as-needed"

    export CFLAGS CXXFLAGS RUSTFLAGS LDFLAGS

    # host cmake 4.x removed compat with cmake_minimum_required(<3.5); several
    # bundled submodules (spirv-headers, ...) still declare ancient minimums
    export CMAKE_POLICY_VERSION_MINIMUM=3.5

    export RUSTUP_TOOLCHAIN=stable
    export CARGO_HOME="${SRCDEST}"/proton-cargo

    cd build
    ROOTLESS_CONTAINER="" \
    ../proton-cachyos/configure.sh \
        --container-engine="none" \
        --proton-sdk-image="" \
        --build-name="${pkgname}" \
        --without-steamrt-depends \
        --without-tts

    SUBJOBS=$([[ "$MAKEFLAGS" =~ -j\ *([1-9][0-9]*) ]] && echo "${BASH_REMATCH[1]}" || echo "$(nproc)") \
        make -j1 dist

    cd dist
    sed -r \
      -e "s|##INSTALL_PATH##|.|" \
      -e "s|##DISPLAY_NAME##|proton-g29-${_srctag} (cachyos native + logitech FFB)|" \
      -e "s|##INTERNAL_TOOL_NAME##|${pkgname}|" \
      "${srcdir}/compatibilitytool.vdf.template" > compatibilitytool.vdf
    # native build: must not require the Steam Linux Runtime container
    # (steamrt4, appid 4183110) — Steam silently fails to launch through it
    sed -i '/require_tool_appid/d' toolmanifest.vdf
    cd ..

    # Vendor the FFB-fixed SDL3 (s8n/SDL-g29) plus a matching sdl2-compat into
    # the dist. The proton launcher prepends files/lib/{x86_64,i386}-linux-gnu
    # to LD_LIBRARY_PATH, so wine's SDL joystick backend (dlopen
    # libSDL2-2.0.so.0 -> sdl2-compat -> libSDL3.so.0) picks these up and
    # wheel force feedback works regardless of the host system's SDL.
    local _sdlarch _triplet _mflag
    for _sdlarch in 64 32; do
        if [ "${_sdlarch}" = 64 ]; then
            _triplet=x86_64-linux-gnu; _mflag=""
        else
            _triplet=i386-linux-gnu; _mflag="-m32"
        fi

        CC="gcc ${_mflag}" CXX="g++ ${_mflag}" \
        cmake -S "${srcdir}"/sdl3-g29 -B sdl3-build-${_sdlarch} \
            -D CMAKE_BUILD_TYPE=None \
            -D CMAKE_INSTALL_PREFIX=/usr \
            -D SDL_STATIC=OFF \
            -D SDL_RPATH=OFF \
            -D SDL_TEST_LIBRARY=OFF
        cmake --build sdl3-build-${_sdlarch} -- -j"$(nproc)"
        DESTDIR="${PWD}"/sdl3-stage-${_sdlarch} cmake --install sdl3-build-${_sdlarch}

        CC="gcc ${_mflag}" CXX="g++ ${_mflag}" \
        cmake -S "${srcdir}"/sdl2-compat-${_sdl2compatver} -B sdl2c-build-${_sdlarch} \
            -D CMAKE_BUILD_TYPE=None \
            -D CMAKE_INSTALL_PREFIX=/usr \
            -D CMAKE_PREFIX_PATH="${PWD}"/sdl3-stage-${_sdlarch}/usr \
            -D SDL2COMPAT_TESTS=OFF
        cmake --build sdl2c-build-${_sdlarch} -- -j"$(nproc)"

        cp -a sdl3-build-${_sdlarch}/libSDL3.so.0* \
              sdl2c-build-${_sdlarch}/libSDL2-2.0.so.0* \
              dist/files/lib/${_triplet}/
    done
}

package() {
    cd build

    # Delete the intermediate build directories to free space (mostly for my github actions)
    rm -rf dst-* obj-* src-* pfx-*

    local _compatdir="${pkgdir}/usr/share/steam/compatibilitytools.d"
    mkdir -p "${_compatdir}/${pkgname}"
    rsync --delete -arx dist/* "${_compatdir}/${pkgname}"

    mkdir -p "${pkgdir}/usr/share/licenses/${pkgname}"
    mv "${_compatdir}/${pkgname}"/{PATENTS.AV1,LICENSE{,.OFL}} \
        "${pkgdir}/usr/share/licenses/${pkgname}"

    # Load ntsync module
    install -Dm644 "$srcdir/ntsync.conf" "$pkgdir/usr/lib/modules-load.d/10-$pkgname.conf"

    cd "${_compatdir}/${pkgname}/files"

    local _geckodir="share/wine/gecko/wine-gecko-${_geckover}"
    i686-w64-mingw32-strip --strip-debug \
        $(find "${_geckodir}"-x86 -iname "*.dll" -or -iname "*.exe")
    x86_64-w64-mingw32-strip --strip-debug \
        $(find "${_geckodir}"-x86_64 -iname "*.dll" -or -iname "*.exe")

    local _monodir="share/wine/mono/wine-mono-${_monover}"
    i686-w64-mingw32-strip --strip-debug \
        $(find "${_monodir}"/lib/mono -iname "*.dll" -or -iname "*.exe")
    i686-w64-mingw32-strip --strip-debug \
        "${_monodir}"/lib/x86/*.dll \
        $(find "${_monodir}" -iname "*x86.dll" -or -iname "*x86.exe")
    x86_64-w64-mingw32-strip --strip-debug \
        "${_monodir}"/lib/x86_64/*.dll \
        $(find "${_monodir}" -iname "*x86_64.dll" -or -iname "*x86_64.exe")
}

b2sums=('SKIP'
        '2a73c12585b502ae11188482cbc9fb1f45f95bfe4383a7615011104b132f4845f9813d01fb40277e1934fab5f1b35ab40b4f4a66a9967463dd1d666a666904e9'
        '62856a88266b4757602c0646e024f832974a93f03b9df253fd4895d4f11a41b435840ad8f7003ec85a0d8087dec15f2e096dbfb4b01ebe4d365521e48fd0c5c0'
        '74555b5f02cb8053ccfb272c30f88e00bb647291ebf57ebd1bce067275ea9184fc0a983d26f4014fa1d6fae53ada9258ddaf11938f0b821fab1bde58257399b1'
        '5a492e5bd62a8116c2571348f01e1ea9dd70e2a185f0891a27be4091c8f182ce55e48f075fe46badf80e0f5b831a1d5993b2b6e1f130f4d6b00e3ef77254d00d'
        'SKIP'
        '1d457e9613f1b2b6e8ef50c80465b31a9fb830c3df1ab8d0d1f20c9dbf00a0dead9c2543be1224ef0e82e29e703d37d88660b7a2853a4bbf1d8bce1b50b0e723'
        'f0a81d83e644ca074a6bf54fc74ae12f5bd047e29d87fab528fba20e4b8d013547ad4b26e912c2b3218a75114f5c76b64aa84fdbc3054d3a1d9bf96635c6212b'
        '964a3ba277821e570aec2127f0d1ae9898da6976c360deb6b196345a50bd3c2c55cb399527507006d8fddef868069032a30b083f23987d5050f185c74dd9de35')
