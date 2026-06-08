# Comptime

`comptime` shifts work to compile time — no runtime cost, and no macros required.

```zig
const std = @import("std");

// Pure function — comptime callable when arguments are comptime-known
fn fibonacci(comptime n: u32) u32 {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// Returns an array of length N filled with 0..N
fn makeRange(comptime N: usize) [N]usize {
    var arr: [N]usize = undefined;
    for (&arr, 0..) |*el, i| el.* = i;
    return arr;
}

pub fn main() void {
    // Evaluated entirely at compile time
    const fib10 = comptime fibonacci(10);
    std.debug.print("fib(10) = {d}\n", .{fib10}); // 55

    const range = comptime makeRange(5);
    std.debug.print("{any}\n", .{range}); // { 0, 1, 2, 3, 4 }

    // comptime type selection
    const T = if (@sizeOf(usize) == 8) u64 else u32;
    const n: T = 100;
    std.debug.print("n = {d}\n", .{n});
}
```

Source: [examples/25-comptime.zig](../examples/25-comptime.zig)

---
[← Previous](24-slices-pointers.md) | [Index](../README.md) | [Next →](26-generics.md)
