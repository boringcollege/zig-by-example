# Arrays

Arrays carry a fixed, compile-time length baked into their type: `[N]T`.

```zig
const std = @import("std");

pub fn main() void {
    // Explicit length
    const primes = [5]u32{ 2, 3, 5, 7, 11 };

    std.debug.print("length: {d}\n", .{primes.len});
    std.debug.print("third: {d}\n", .{primes[2]});

    // Infer length with _
    const odds = [_]u32{ 1, 3, 5, 7, 9 };
    std.debug.print("sum: {d}\n", .{odds[0] + odds[4]});

    // Mutable array
    var buf = [_]u8{ 'a', 'b', 'c' };
    buf[0] = 'z';
    std.debug.print("{s}\n", .{buf});

    // Multi-dimensional
    const matrix = [2][3]i32{
        .{ 1, 2, 3 },
        .{ 4, 5, 6 },
    };
    std.debug.print("{d}\n", .{matrix[1][2]});
}
```