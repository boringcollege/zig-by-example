# Blocks and Statements

Blocks are expressions, and they can return a value via a labeled `break`.

```zig
const std = @import("std");

pub fn main() void {
    // Block as expression
    const x = blk: {
        const a = 10;
        const b = 20;
        break :blk a + b;
    };
    std.debug.print("x = {d}\n", .{x}); // 30

    // Labeled break from nested loops
    const result = outer: {
        var sum: u32 = 0;
        for (0..10) |i| {
            if (i == 5) break :outer sum;
            sum += @intCast(i);
        }
        break :outer sum;
    };
    std.debug.print("result = {d}\n", .{result}); // 10
}
```

Source: [examples/14-blocks-and-statements.zig](../examples/14-blocks-and-statements.zig)

---
[← Previous](13-functions.md) | [Index](../README.md) | [Next →](15-if-else.md)
