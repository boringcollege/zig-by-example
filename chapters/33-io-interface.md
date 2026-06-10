# Io Interface

Zig 0.16 introduces `std.Io`, one interface the standard library uses for
every blocking operation: file I/O, networking, processes, sleeping,
entropy, threading primitives, and (eventually) async / await.

You build a single `Io` value at the top of `main` and thread it through
everything. The default implementation, `std.Io.Threaded`, runs each
operation on a real OS thread. On supported platforms you can swap in an
evented backend (`std.Io.Evented`, built on epoll / kqueue / io_uring)
without touching the rest of your code.

```zig
const std = @import("std");

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    // std.Io.Threaded is the default Io implementation — it backs each
    // concurrent unit of work with a real OS thread. An evented backend
    // (epoll / kqueue / io_uring) is also available on supported platforms.
    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();

    // The `Io` value is a small fat-pointer (userdata + vtable). Pass it
    // to every function that touches the OS: file I/O, networking,
    // processes, sync primitives, sleeping, and entropy.
    const io: std.Io = io_impl.io();

    // Sleep is dispatched through Io rather than the syscall directly,
    // so an evented Io can suspend the fiber instead of blocking a thread.
    std.debug.print("sleeping 50ms...\n", .{});
    try io.sleep(.fromMilliseconds(50), .awake);

    // Entropy: io.random fills a buffer with cryptographically secure bytes.
    var seed: u64 = undefined;
    io.random(std.mem.asBytes(&seed));
    std.debug.print("seed: {d}\n", .{seed});

    // Now anything that needs Io can use the same value. Here we
    // create a child process — see chapter 37 for more.
    const r = try std.process.run(gpa, io, .{ .argv = &.{ "echo", "Io is wired up" } });
    defer gpa.free(r.stdout);
    defer gpa.free(r.stderr);
    std.debug.print("{s}", .{r.stdout});
}
```

## Why this matters

Before 0.16, file and network code talked directly to the OS, so switching
between blocking and async meant rewriting or duplicating libraries.

By routing every operation through `Io`, the same library code can run:

- **blocking** (one thread per request, easiest to reason about)
- **multi-threaded** (`std.Io.Threaded` — what we just used)
- **evented** (`std.Io.Evented` — fibers on top of io_uring / kqueue / epoll)
- **mocked** (a test backend that records or replays operations)

without changing a single line. The rest of this book sticks with `Threaded`.

Source: [examples/33-io-interface.zig](../examples/33-io-interface.zig)

---
[← Previous](32-formatting-and-print.md) | [Index](../README.md) | [Next →](34-writer-reader.md)
