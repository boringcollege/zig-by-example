# Vectors

SIMD vectors let you do data-parallel math.

```zig
const std = @import("std");

pub fn main() void {
    const a: @Vector(4, f32) = .{ 1, 2, 3, 4 };
    const b: @Vector(4, f32) = .{ 10, 20, 30, 40 };

    // Element-wise math is a single SIMD instruction on most targets
    const c = a + b;
    std.debug.print("{d}\n", .{c}); // { 11, 22, 33, 44 }

    // Reduce to scalar
    const total = @reduce(.Add, c);
    std.debug.print("sum: {d}\n", .{total}); // 110

    // Splat — broadcast a scalar
    const ones: @Vector(4, f32) = @splat(1.0);
    std.debug.print("{d}\n", .{a + ones});
}
```