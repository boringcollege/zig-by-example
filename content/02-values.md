# Values

Zig doesn't do implicit type coercions — every value carries a concrete type.

```zig
const std = @import("std");

pub fn main() void {
    // Boolean
    const t: bool = true;
    const f: bool = false;

    // Integers
    const n: i32 = -42;
    const m: u64 = 1_000_000;

    // Float
    const pi: f64 = 3.14159;

    // Comptime-known integer — type is inferred as comptime_int
    const big = 1 << 40;

    std.debug.print("{} {} {} {} {d} {}\n", .{ t, f, n, m, pi, big });
}
```

`const` declares an immutable binding. The type annotation after `:` is
optional when the compiler can figure it out on its own. For floats, use `{d}`
to force decimal formatting — the bare `{}` may pick something else.

Source: [examples/02-values.zig](../examples/02-values.zig)

---
[← Previous](01-hello-world.md) | [Index](../README.md) | [Next →](03-variables.md)
