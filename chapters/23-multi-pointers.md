# Multi-Pointers

`[*]T` is a many-item pointer — basically a C pointer, with no length attached.

```zig
const std = @import("std");

pub fn main() void {
    var arr = [_]u32{ 10, 20, 30, 40 };

    // Coerce array to many-pointer
    const p: [*]u32 = &arr;

    std.debug.print("{d}\n", .{p[0]}); // 10
    std.debug.print("{d}\n", .{p[2]}); // 30

    // Arithmetic
    const p2 = p + 1;
    std.debug.print("{d}\n", .{p2[0]}); // 20

    // Convert back to a slice with known length
    const s: []u32 = p[0..arr.len];
    std.debug.print("len: {d}\n", .{s.len});
}
```

Reach for `[*]T` when you're talking to C APIs. In pure Zig code, prefer slices
(`[]T`) — they carry their length around and rule out a whole class of bugs.

Source: [examples/23-multi-pointers.zig](../examples/23-multi-pointers.zig)

---
[← Previous](22-pointers.md) | [Index](../README.md) | [Next →](24-slices-pointers.md)
