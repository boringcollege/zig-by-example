# Memory Allocation

Zig never allocates behind your back — you always pick the allocator yourself.

```zig
const std = @import("std");

pub fn main() !void {
    // DebugAllocator detects leaks and double-frees in Debug builds.
    // It replaces the older GeneralPurposeAllocator name.
    var dbg: std.heap.DebugAllocator(.{}) = .init;
    defer _ = dbg.deinit();
    const allocator = dbg.allocator();

    // Allocate a slice
    const buf = try allocator.alloc(u8, 64);
    defer allocator.free(buf);

    @memset(buf, 0);
    buf[0] = 'Z';
    buf[1] = 'i';
    buf[2] = 'g';
    std.debug.print("{s}\n", .{buf[0..3]});

    // Allocate a single value
    const p = try allocator.create(i32);
    defer allocator.destroy(p);
    p.* = 42;
    std.debug.print("{d}\n", .{p.*});

    // ArenaAllocator — bulk-free everything at the end
    var arena: std.heap.ArenaAllocator = .init(allocator);
    defer arena.deinit();
    const a = arena.allocator();

    const s1 = try a.dupe(u8, "fast");
    const s2 = try a.dupe(u8, "alloc");
    std.debug.print("{s} {s}\n", .{ s1, s2 });

    // FixedBufferAllocator — no OS call at all
    var fb_buf: [256]u8 = undefined;
    var fb: std.heap.FixedBufferAllocator = .init(&fb_buf);
    const fa = fb.allocator();
    const xs = try fa.alloc(u32, 4);
    for (xs, 0..) |*x, i| x.* = @intCast(i * i);
    std.debug.print("{any}\n", .{xs});
}
```

Common allocators in 0.16:

- `std.heap.DebugAllocator` — debug-friendly with leak detection (was `GeneralPurposeAllocator`)
- `std.heap.smp_allocator` — thread-safe, the recommended general-purpose default in release builds
- `std.heap.page_allocator` — direct OS pages, no overhead tracking
- `std.heap.ArenaAllocator` — free everything at once
- `std.heap.FixedBufferAllocator` — allocates from a stack/global buffer, no OS call

Source: [examples/27-memory-allocation.zig](../examples/27-memory-allocation.zig)

---
[← Previous](26-generics.md) | [Index](../README.md) | [Next →](28-arraylist.md)
