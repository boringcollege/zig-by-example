# Functions

Functions are first-class — you can store them, pass them, and return them.

```zig
const std = @import("std");

fn add(a: i32, b: i32) i32 {
    return a + b;
}

// Multiple return values via an anonymous struct
fn divmod(a: u32, b: u32) struct { q: u32, r: u32 } {
    return .{ .q = a / b, .r = a % b };
}

// Function taking a function pointer — note the *const fn(...) form
fn applyTwice(f: *const fn (i32) i32, x: i32) i32 {
    return f(f(x));
}

fn double(x: i32) i32 {
    return x * 2;
}

pub fn main() void {
    std.debug.print("{d}\n", .{add(3, 4)});

    const dm = divmod(17, 5);
    std.debug.print("17 / 5 = {d} rem {d}\n", .{ dm.q, dm.r });

    std.debug.print("{d}\n", .{applyTwice(double, 3)}); // 12

    // Function pointer variable
    const op: *const fn (i32, i32) i32 = add;
    std.debug.print("{d}\n", .{op(10, 20)});
}
```

A *function value* (one you hold in a variable) has pointer type `*const fn(...) T`,
while the *function type* `fn(...) T` is only useful as a comptime constraint.

Source: [examples/13-functions.zig](../examples/13-functions.zig)

---
[← Previous](12-unions.md) | [Index](../README.md) | [Next →](14-blocks-and-statements.md)
