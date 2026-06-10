# Threading & Concurrency

`std.Thread` spawns OS threads. The synchronization primitives — `Mutex`,
`Condition`, `Semaphore`, `RwLock` — now live under `std.Io`, since the
same code should also work on top of an evented `Io` backend.

```zig
const std = @import("std");

const Counter = struct {
    value: u64 = 0,
    mutex: std.Io.Mutex = .init,
};

fn worker(io: std.Io, counter: *Counter, iterations: usize) void {
    var i: usize = 0;
    while (i < iterations) : (i += 1) {
        counter.mutex.lock(io) catch return;
        defer counter.mutex.unlock(io);
        counter.value += 1;
    }
}

pub fn main() !void {
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const gpa = dbg.allocator();

    var io_impl: std.Io.Threaded = .init(gpa, .{});
    defer io_impl.deinit();
    const io = io_impl.io();

    var counter: Counter = .{};

    // std.Thread.spawn runs `worker` on an OS thread.
    // Mutex / Condition now live under std.Io and take the Io value, so
    // an evented backend can suspend a fiber instead of blocking.
    const t1 = try std.Thread.spawn(.{}, worker, .{ io, &counter, 100_000 });
    const t2 = try std.Thread.spawn(.{}, worker, .{ io, &counter, 100_000 });
    const t3 = try std.Thread.spawn(.{}, worker, .{ io, &counter, 100_000 });

    t1.join();
    t2.join();
    t3.join();

    std.debug.print("final count: {d}\n", .{counter.value}); // 300000

    // Quick atomic counter — no lock needed for primitive integer ops.
    var atomic: std.atomic.Value(u32) = .init(0);
    _ = atomic.fetchAdd(5, .monotonic);
    _ = atomic.fetchAdd(7, .monotonic);
    std.debug.print("atomic: {d}\n", .{atomic.load(.monotonic)});
}
```

If all you need is a counter or a flag, reach for `std.atomic.Value(T)`
instead of a mutex — it stays lock-free on every supported platform.

Source: [examples/36-threading.zig](../examples/36-threading.zig)

---
[← Previous](35-file-io.md) | [Index](../README.md) | [Next →](37-processes.md)
