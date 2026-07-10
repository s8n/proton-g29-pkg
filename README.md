# proton-g29

Arch/CachyOS PKGBUILD for **proton-g29**, a Steam Play compatibility tool:
[proton-cachyos](https://github.com/CachyOS/proton-cachyos) (native build)
with working Logitech wheel support — input mapping *and* force feedback —
for the G29 family (G29/G27/G25/Driving Force GT/DFP) on the plain SDL path,
no hidraw passthrough hacks. Might also help with others, especially with force feedback.

Shows up in Steam as **`proton-g29-<version> (cachyos native + logitech FFB)`**
and installs side by side with other Proton versions.

## What it fixes

- **wine** ([s8n/wine-g29](https://github.com/s8n/wine-g29)): native HID axis
  usages and report order for the G29, unsigned axis ranges (fixes the
  ecosystem-wide "wheel only steers right / pedals die half-way" bug,
  ValveSoftware/Proton#5351), single-axis FFB direction handling, and SDL
  haptic error logging.
- **SDL** ([s8n/SDL-g29](https://github.com/s8n/SDL-g29)): four bugs in the
  lg4ff HIDAPI haptic driver that made wheel FFB slam to full lock or fall
  silent (slot init, signed/unsigned envelope arithmetic, envelope restarts
  on every parameter update, infinite-duration effects running fade math).
  The fixed SDL3 + sdl2-compat are vendored inside the tool so the host
  system's SDL doesn't matter. Upstreaming is planned; the vendored branch is
  deliberately named `donotupstream-…` pending a clean rewrite.
- **proton** ([s8n/proton-g29](https://github.com/s8n/proton-g29)): points the
  wine submodule at the fixed wine.

## Install

Arch-based distros:

```
makepkg -si
```

or grab the built package from the releases and `pacman -U` it. Restart Steam,
then per game: Properties → Compatibility → `proton-g29-…`.

Non-Arch distros, the Steam Deck, or anywhere you want one artifact that runs
regardless of the host system: use the **SLR build** (Proton compiled inside
the Steam Linux Runtime container, GE-Proton style) — see
[`slr/BUILD.md`](slr/BUILD.md). It produces a `proton-g29-slr.tar.xz` you
extract into `~/.steam/root/compatibilitytools.d/` and restart Steam.

(A dist tarball from the *native* build above also drops into
`~/.steam/root/compatibilitytools.d/`, but it's host-linked — no promises it'll
work off-Arch. The SLR build is the portable one.)

## Notes

- The PKGBUILD builds the 20260702 proton tag natively (outside the Steam
  Linux Runtime container). Nothing else does that yet, so it carries a set
  of host-build fixes: a `none` container-engine shim, steamrt-style
  toolchain/pkg-config wrappers, `-Dgssapi=disabled` for 32-bit libsoup,
  restored wine OpenCL linkage, `CMAKE_POLICY_VERSION_MINIMUM` for legacy
  submodules, an `afdko` dispatcher shim, and the Steam Linux Runtime
  requirement stripped from `toolmanifest.vdf`.
- This package is unsupported by Valve and CachyOS, don't report issues with
  it to them.
