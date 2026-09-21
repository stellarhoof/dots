## seats

A _seat_ is an abstraction for a set of hardware devices. Conceptually, a seat bundles:

- **Graphics devices**: DRM cards, their connectors/outputs, backlight, framebuffer.
- **Input devices**: keyboards, mice, touchpads, touchscreen, lid/power/video buttons.

Devices in use by current seats can be listed with `loginctl seat-status`

A computer (single OS/kernel) may be shared by multiple seats to allow concurrent use (e.g. a classroom PC with multiple monitors/keyboards/mice).

Devices get assigned to seats by `udev`.

A seat has exactly one active _session_ at a time. The session owns the seat's devices. The active session is changed when VTs (ttyN) are changed.

## libseat

`libseat` is a small seat management library. It allows an unprivileged process gain access to a seat's devices without being root. Historically this was solved either by running the process (display server, console, etc...) as root, or via `setuid` helpers (`Xorg.wrap`, `weston-launch`) which are ugly and hard to secure. `libseat` instead vets the caller, opens the device nodes itself, and hands the file descriptors to the client over a unix socket.

When a VT is switched away from:

1. The seat manager daemon (e.g. `elogind`) emits a `pause` for the session.
2. `libseat` receives the `pause` and executes a cleanup callback specific to the process using `libseat`. For example, the niri compositor stops rendering, closes its DRM device fds (dropping DRM master), and stops reading input.
