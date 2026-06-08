const std = @import("std");

pub fn main() void {
    const score: u32 = 75;

    if (score >= 90) {
        std.debug.print("A\n", .{});
    } else if (score >= 80) {
        std.debug.print("B\n", .{});
    } else if (score >= 70) {
        std.debug.print("C\n", .{});
    } else {
        std.debug.print("F\n", .{});
    }

    // if as expression
    const label = if (score >= 60) "pass" else "fail";
    std.debug.print("{s}\n", .{label});

    // Unwrap an optional with capture
    const maybe: ?i32 = 42;
    if (maybe) |val| {
        std.debug.print("got: {d}\n", .{val});
    } else {
        std.debug.print("null\n", .{});
    }

    // Direct null check
    const nothing: ?i32 = null;
    if (nothing == null) std.debug.print("nothing here\n", .{});
}
