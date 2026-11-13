# Darwin ARM64 system bindings

This library owns the Apple Silicon syscall and Mach trap calling conventions. The inline register and syscall operations live here. Consumers use ordinary Novus functions.

- `darwin_syscall` accepts a Darwin BSD syscall number and up to six unsigned arguments. It returns a small result or negative errno.
- `monotonic_ms` reads the Mach absolute clock and scales it to milliseconds using the Mach timebase.
- `sync_file` flushes a file descriptor and retries interruption.
- `lock_file` acquires an exclusive, nonblocking advisory lock for the lifetime of the descriptor.

Syscall numbers and ARM64 Mach trap conventions come from [Apple's XNU source](https://github.com/apple-oss-distributions/xnu/blob/main/bsd/kern/syscalls.master) and the macOS SDK.
