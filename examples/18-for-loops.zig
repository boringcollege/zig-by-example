const std = @import("std");

pub fn main() void {
    const fruits = [_][]const u8{ "apple", "banana", "cherry" };

    // Value only
    for (fruits) |fruit| {
        std.debug.print("{s}\n", .{fruit});
    }

    // Value and index
    for (fruits, 0..) |fruit, i| {
        std.debug.print("{d}: {s}\n", .{ i, fruit });
    }

    // Range (start..end, end exclusive)
    for (1..6) |n| {
        std.debug.print("{d} ", .{n});
    }
    std.debug.print("\n", .{});

    // Zip two slices of equal length
    const a = [_]i32{ 1, 2, 3 };
    const b = [_]i32{ 10, 20, 30 };
    for (a, b) |x, y| {
        std.debug.print("{d} ", .{x + y});
    }
    std.debug.print("\n", .{});

    // break / continue
    for (0..10) |n| {
        if (n % 2 == 0) continue;
        std.debug.print("{d} ", .{n});
    }
    std.debug.print("\n", .{});
}
