const std = @import("std");

fn increment(p: *i32) void {
    p.* += 1;
}

pub fn main() void {
    var x: i32 = 10;

    // Take address
    const p: *i32 = &x;

    // Dereference
    std.debug.print("before: {d}\n", .{p.*});
    increment(p);
    std.debug.print("after: {d}\n", .{x}); // 11

    // Pointer to a struct field
    var point = struct { x: f32, y: f32 }{ .x = 1.0, .y = 2.0 };
    const px: *f32 = &point.x;
    px.* = 99.0;
    std.debug.print("point.x = {d}\n", .{point.x});

    // Pointer equality — compares addresses, not contents
    var u: u8 = 1;
    var v: u8 = 1;
    std.debug.print("same: {}\n", .{&u == &u}); // true
    std.debug.print("diff: {}\n", .{&u == &v}); // false
    u +%= 0; // touch so it isn't const-promoted
    v +%= 0;
}
