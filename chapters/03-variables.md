# Variables

`var` declares a mutable binding. Every variable has to be initialized.

```zig
const std = @import("std");

pub fn main() void {
    var x: i32 = 1;
    x += 1;
    std.debug.print("x = {d}\n", .{x});

    // Type inference with var
    var y = @as(f32, 2.5);
    y *= 2.0;
    std.debug.print("y = {d}\n", .{y});
}
```

Zig won't compile a `var` that's never mutated — reach for `const` in that case.

Source: [examples/03-variables.zig](../examples/03-variables.zig)

---
[← Previous](02-values.md) | [Index](../README.md) | [Next →](04-integers.md)
