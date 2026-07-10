# Building proton-g29 the SLR (Steam Linux Runtime) way

This is the **universal / Steam Deck** build of proton-g29: Proton is compiled
*inside* the Steam Linux Runtime 4 (steamrt4) SDK container — the same way
GE-Proton and upstream Proton are built — so a single artifact runs on the
Steam Deck and every Linux distribution, regardless of the host's glibc or
system libraries.

Contrast with the [`PKGBUILD`](../PKGBUILD) in this repo, which is the
**Arch-native** build (a pacman package, host-linked, container requirement
stripped). If you're on Arch/CachyOS and only building for your own machines,
the PKGBUILD is simpler. For everyone else — Deck, Ubuntu, Fedora, Bazzite,
distributing to strangers — use this SLR build.

The result is a GE-style tarball you extract into
`~/.steam/root/compatibilitytools.d/`.

---

## Prerequisites

- **Docker** (or Podman) — the build runs in a container. `configure.sh`
  autodetects `docker` then `podman`.
- **Disk**: Docker stores the ~7 GB SDK image under `/var/lib/docker` (on `/`
  by default). The build tree (`build/`) needs ~15–20 GB and can live anywhere;
  put it on a roomy partition. If `/` is tight, move Docker's data-root
  (`/etc/docker/daemon.json` → `"data-root": "/mnt/somewhere/docker"`, then
  restart dockerd) or `docker image prune`.
- **The proton-g29 source tree** with all submodules (see step 1). This is the
  Proton fork ([s8n/proton-g29](https://github.com/s8n/proton-g29)) whose
  `wine` submodule points at the FFB-fixed
  [s8n/wine-g29](https://github.com/s8n/wine-g29).
- **The fixed SDL sources**: [s8n/SDL-g29](https://github.com/s8n/SDL-g29)
  (branch `donotupstream-g29-ffb-fixes/3.4.12`) and an sdl2-compat tarball
  (2.32.70 is what this repo pins).

---

## Step 1 — Get the Proton source with all submodules

```bash
git clone https://github.com/s8n/proton-g29.git
cd proton-g29
git checkout cachyos_11.0_20260702/g29
git submodule update --init --recursive --force
```

The `--force` matters: a plain init can leave submodules on branch tips instead
of the exact pinned commits. Verify the tree is clean and complete:

```bash
# every line should start with a space (matched gitlink); none with - or +
git submodule status --recursive | awk '{print substr($0,1,1)}' | sort | uniq -c
# the wine fork must carry the FFB fixes:
git submodule status wine   # -> d6646e428b28e... (cachyos-...-proton-slr-...)
```

### Troubleshooting submodules

- **`wine` clones over SSH and fails** (`git@github.com: Permission denied`):
  a stale `.git/config` holds the old SSH URL. Re-sync it from `.gitmodules`
  (which uses HTTPS) and retry:
  ```bash
  git submodule sync wine
  git submodule update --init --recursive wine
  ```
  A failed wine clone *aborts* the recursive walk, which leaves **nested**
  submodules of later modules uninitialized — the usual symptom is the
  dxvk-nvapi error below. After fixing the URL, re-run the full
  `git submodule update --init --recursive --force`.

- **`meson.build: ERROR: Include dir ./external/Vulkan-Headers/include does not
  exist`** during the build: dxvk-nvapi's *nested* submodule wasn't checked
  out. Fix the recursive init (above), then force a clean re-sync of just that
  component and resume the build:
  ```bash
  cd <build-dir>
  rm -rf src-dxvk-nvapi src-dxvk-nvapi-vkreflex-layer obj-dxvk-nvapi-* \
         .dxvk-nvapi-source .dxvk-nvapi-post-source \
         .dxvk-nvapi-vkreflex-layer-source
  make redist        # everything else keeps its stamps and won't rebuild
  ```

---

## Step 2 — Configure and build

Build out-of-tree, next to the source:

```bash
mkdir ../build && cd ../build
../proton-g29/configure.sh \
    --container-engine=docker \
    --build-name=proton-g29 \
    --enable-ccache \
    --without-tts            # optional: faster first build; drop for a full release
make redist
```

`configure.sh` pulls/uses the steamrt4 SDK image pinned in the Proton
`Makefile.in` (`registry.gitlab.steamos.cloud/proton/steamrt4/sdk/x86_64:…`)
and writes a `Makefile`. `make redist` then runs the whole build inside that
container and, on success, leaves the redistributable tree at
`build/proton-g29/` (plus a bare `proton-g29.tar.xz` that does **not** yet have
our SDL — we replace it in step 5).

Cold ccache ⇒ expect a long build (~1–3 h). Warm ccache is far faster.

Note: unlike the Arch-native build, **none of the host-build workarounds are
needed here** (no `none` container shim, no pkg-config/toolchain wrappers, no
`-Dgssapi=disabled`, no OpenCL relink, no `-march` pinning). The container has
the right toolchain, which is the whole point of this tier.

---

## Step 3 — Vendor the FFB-fixed SDL

Proton ships **no** SDL in `files/lib`, so at runtime wine's joystick backend
(`winebus`) would otherwise `dlopen` the runtime's SDL2. We drop our fixed
libraries into `files/lib/{x86_64,i386}-linux-gnu/`; the Proton launcher
prepends those dirs to `LD_LIBRARY_PATH`, so ours win. The chain is:

```
winebus  --dlopen "libSDL2-2.0.so.0"-->  our sdl2-compat
                                              --dlopen "libSDL3.so.0"-->  our fixed SDL3 (lg4ff FFB)
```

Build both libraries **inside the same SDK container** (so their ABI matches
the runtime) and inject them with the helper script
[`inject-sdl-incontainer.sh`](./inject-sdl-incontainer.sh):

```bash
# from the build dir; adjust paths to your checkouts
SDK=registry.gitlab.steamos.cloud/proton/steamrt4/sdk/x86_64:4.0.20260331.220802-0
SDL3_SRC=/path/to/SDL-g29                     # branch donotupstream-g29-ffb-fixes/3.4.12
SDL2COMPAT_SRC=/path/to/sdl2-compat-2.32.70   # extracted tarball
DEST=$PWD/proton-g29/files/lib

docker run --rm -u "$(id -u):$(id -g)" -e HOME=/tmp \
  -v "$SDL3_SRC:$SDL3_SRC:ro" \
  -v "$SDL2COMPAT_SRC:$SDL2COMPAT_SRC:ro" \
  -v "$DEST:$DEST" \
  -v "$PWD/../proton-g29-pkg/slr/inject-sdl-incontainer.sh:/inject.sh:ro" \
  -e SDL3_SRC -e SDL2COMPAT_SRC -e DEST -e WORK=/tmp/sdlbuild \
  "$SDK" bash /inject.sh
```

Verify (all should hold):

```bash
cd proton-g29/files/lib
file x86_64-linux-gnu/libSDL2-2.0.so.0.*   # ELF 64-bit
file i386-linux-gnu/libSDL2-2.0.so.0.*     # ELF 32-bit
# sdl2-compat must dlopen (NOT link) SDL3 — NEEDED should be libc only:
objdump -p x86_64-linux-gnu/libSDL2-2.0.so.0 | grep NEEDED
# the fixed lg4ff driver must be in our SDL3:
strings x86_64-linux-gnu/libSDL3.so.0 | grep -i 'lg4ff\|Logitech G29'
```

---

## Step 4 — Set the tool name (keep the runtime requirement!)

Edit `proton-g29/compatibilitytool.vdf`:

- Internal name (the vdf key) — pick something that won't collide with other
  proton-g29 installs, e.g. `proton-g29-slr`. **Steam stores this per game;
  don't rename it after people start using it.**
- `display_name` — what shows in the dropdown, e.g.
  `proton-g29-11.0-20260702 (SLR + logitech FFB)`.

**Do NOT touch `toolmanifest.vdf`.** It keeps `"require_tool_appid" "4183110"`
(the steamrt4 SLR) — that's how Steam runs this build inside the matching
runtime container and auto-installs it. (Stripping this line is only correct
for the *native* build.)

---

## Step 5 — Package

```bash
mv proton-g29 proton-g29-slr        # match the internal name
tar -caf proton-g29-slr.tar.xz proton-g29-slr
sha512sum proton-g29-slr.tar.xz > proton-g29-slr.sha512sum
```

Upload the `.tar.xz` + `.sha512sum` to a GitHub release. Users install by
extracting into `~/.steam/root/compatibilitytools.d/` (or via ProtonUp-Qt /
ProtonPlus once it's in their source list).

---

## Install & verify

```bash
tar -xf proton-g29-slr.tar.xz -C ~/.steam/root/compatibilitytools.d/
# restart Steam (it caches compat tools + manifests at startup)
```

Per game: Properties → Compatibility → **proton-g29-… (SLR + logitech FFB)**.
On first launch Steam downloads the steamrt4 runtime (appid 4183110) if it
isn't already installed.

**The one check that reading code can't settle** — that our vendored SDL
actually wins under pressure-vessel (nothing pre-loads the runtime's SDL first):

```bash
# with the game running, find its wine process and inspect mapped SDL:
pid=$(pgrep -f 'winedevice.exe' | head -1)
grep -i sdl /proc/$pid/maps
# EXPECT paths under .../compatibilitytools.d/proton-g29-slr/files/lib/...
# NOT /usr/lib/... (which would mean the runtime's SDL got loaded instead)
```

If FFB works and the maps show our paths, the vendoring is sound. If FFB slams
to lock or goes silent and maps show `/usr/lib`, the runtime's SDL was loaded
before winebus — the fallback would be an `LD_PRELOAD` of our lib or teaching
winebus to `dlopen` an absolute path into `files/lib`.

---

## Notes

- **glibc**: the injected libs require ≤ GLIBC_2.38; the steamrt4 runtime
  provides 2.41, and Proton's own binaries were built against the same, so
  it's consistent by construction. This is *why* the SDL must be built in the
  SDK container rather than on the host.
- **TTS**: `--without-tts` skips OpenFST/VOSK/Kaldi/Piper for a faster build.
  Drop it for a full-featured release.
- This build is unsupported by Valve and CachyOS — don't report issues with it
  to them.
