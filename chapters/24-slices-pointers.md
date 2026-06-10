# Slices (Pointers)

Let's revisit slices, this time from a memory point of view.

```zig
const std = @import("std");

pub fn main() void {
    var data = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8 };
    const s = data[2..6]; // { 3, 4, 5, 6 }

    // A slice is really pointer + length
    std.debug.print("ptr: {*}\n", .{s.ptr});
    std.debug.print("len: {d}\n", .{s.len});

    // Sentinel-terminated slice — std.mem.span walks until the sentinel
    const cstr: [*:0]const u8 = "hello";
    const span = std.mem.span(cstr);
    std.debug.print("{s} len={d}\n", .{ span, span.len });
}
```

Source: [examples/24-slices-pointers.zig](../examples/24-slices-pointers.zig)

---
[← Previous](23-multi-pointers.md) | [Index](../README.md) | [Next →](25-comptime.md)
