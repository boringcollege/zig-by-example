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
