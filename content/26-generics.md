# Generics

In Zig, generics are just functions that take a `type` parameter at comptime.

```zig
const std = @import("std");

// Generic Stack backed by a fixed-size array
fn Stack(comptime T: type, comptime capacity: usize) type {
    return struct {
        items: [capacity]T = undefined,
        len: usize = 0,

        const Self = @This();

        pub fn push(self: *Self, item: T) !void {
            if (self.len >= capacity) return error.Full;
            self.items[self.len] = item;
            self.len += 1;
        }

        pub fn pop(self: *Self) ?T {
            if (self.len == 0) return null;
            self.len -= 1;
            return self.items[self.len];
        }
    };
}

pub fn main() void {
    var s: Stack(i32, 8) = .{};
    s.push(1) catch unreachable;
    s.push(2) catch unreachable;
    s.push(3) catch unreachable;

    while (s.pop()) |v| {
        std.debug.print("{d}\n", .{v}); // 3, 2, 1
    }
}
```

Source: [examples/26-generics.zig](../examples/26-generics.zig)

---
[← Previous](25-comptime.md) | [Index](../README.md) | [Next →](27-memory-allocation.md)
