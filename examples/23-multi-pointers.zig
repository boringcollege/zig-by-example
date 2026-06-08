const std = @import("std");

pub fn main() void {
    var arr = [_]u32{ 10, 20, 30, 40 };

    // Coerce array to many-pointer
    const p: [*]u32 = &arr;

    std.debug.print("{d}\n", .{p[0]}); // 10
    std.debug.print("{d}\n", .{p[2]}); // 30

    // Arithmetic
    const p2 = p + 1;
    std.debug.print("{d}\n", .{p2[0]}); // 20

    // Convert back to a slice with known length
    const s: []u32 = p[0..arr.len];
    std.debug.print("len: {d}\n", .{s.len});
}
